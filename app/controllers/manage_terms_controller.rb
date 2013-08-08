class ManageTermsController < ApplicationController
  layout "supr"
  before_filter :login_required, :except => :public_terms
  before_filter :check_permissions, :except => :public_terms
  tabs :default => :manage_terms

  def index
    @page_title = "ToS"
    @active_page = "cms_terms"
    @tos = StaticPage.where(:static_key => 'tos').first

    if @tos.blank?
      @tos = StaticPage.new
      @tos.static_key = "tos"
      @tos.save
    end
  end

  def public_terms
    @tos = StaticPage.where(:static_key => 'tos').first

    render :layout => "plus"
  end

  def edit
    @page_title = "ToS"
    @active_page = "cms_terms"
    @tos = StaticPage.where(:static_key => 'tos').first

    if @tos.blank?
      @tos = StaticPage.new
      @tos.static_key = "tos"
      @tos.save
    end
  end

  def update
    @tos = StaticPage.find(params[:id])
    if @tos.blank?
      flash[:error] = "Static Page not Found"
      redirect_to cms_terms_path
    else
      @tos.static_content = params[:tos_content]
      @tos.user_id = current_user.id
      if @tos.valid? && @tos.save
        flash[:notice] = "Terms of Use updated"
        redirect_to cms_terms_path
      else
        flash[:error] = @tos.errors.first[1] rescue "Terms of Use invalid"
        redirect_to cms_terms_path
      end
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
