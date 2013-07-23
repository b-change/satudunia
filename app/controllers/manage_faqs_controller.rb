class ManageFaqsController < ApplicationController
  layout "supr"
  before_filter :login_required, :except => :public_faq
  before_filter :check_permissions, :except => :public_faq
  tabs :default => :manage_faq

  def index
    @page_title = "FAQ"
    @active_page = "manage_faq"
    @faq = Faq.new
    @faqs = Faq.all.page(params[:page])
  end

  def create
    @faq = Faq.new(params[:faq])
    if @faq.valid? && @faq.save
      flash[:notice] = "Faq created"
      redirect_to admin_faq_path
    else
      flash[:error] = @faq.errors.first[1] rescue "Faq invalid"
      redirect_to admin_faq_path(:tab => 'new')
    end
  end

  def update
    @faq = Faq.find(params[:id])

    if @faq.present?
      @faq.safe_update(%w[faq_question faq_answer], params[:faq])
      if @faq.valid? && @faq.save
        flash[:notice] = "Faq updated"
        redirect_to admin_faq_path
      else
        flash[:error] = @faq.errors.first[1] rescue "Faq invalid"
        redirect_to admin_faq_path(:tab => 'new')
      end
    else
      flash[:error] = "Faq not found"
      redirect_to admin_faq_path
    end
  end

  def public_faq
    @faqs = Faq.all.page(params[:page])

    render :layout => "experiment"
  end

  def destroy
    @faq = Faq.find(params[:id])

    if @faq.present?
      @faq.destroy()
      flash[:notice] = "Faq deleted"
      redirect_to manage_faqs_path
    else
      flash[:error] = "Faq not found"
      redirect_to manage_faqs_path
    end
  end

  protected
  def check_permissions
    @group = current_group

    if !current_user.owner_of?(@group)
      flash[:notice] = t("global.permission_denied")
      redirect_to domain_url(:custom => current_group.domain)
    end
  end
end