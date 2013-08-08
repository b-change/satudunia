class ManageAboutsController < ApplicationController
  layout "supr"
  before_filter :login_required, :except => :public_about
  before_filter :check_permissions, :except => :public_about
  tabs :default => :manage_about

  def index
    @page_title = "About"
    @active_page = "cms_about"
    @about = StaticPage.where(:static_key => 'about').first

    if @about.blank?
      @about = StaticPage.new
      @about.static_key = "about"
      @about.save
    end
  end

  def public_about
    @about = StaticPage.where(:static_key => 'about').first

    render :layout => "plus"
  end

  def edit
    @page_title = "About"
    @active_page = "cms_about"
    @about = StaticPage.where(:static_key => 'about').first

    if @about.blank?
      @about = StaticPage.new
      @about.static_key = "about"
      @about.save
    end
  end

  def update
    @about = StaticPage.find(params[:id])

    if @about.blank?
      flash[:error] = "Static Page not Found"
      redirect_to cms_abouts_path
    else
      @about.static_content = params[:about_content]
      @about.user_id = current_user.id
      if @about.valid? && @about.save
        flash[:notice] = "About updated"
        redirect_to cms_abouts_path
      else
        flash[:error] = @about.errors.first[1] rescue "About invalid"
        redirect_to cms_abouts_path
      end
    end
  end

  def experimental_about
    @about = StaticPage.where(:static_key => 'about').first

    render :layout => "plus"
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
