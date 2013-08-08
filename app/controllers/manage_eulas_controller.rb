class ManageEulasController < ApplicationController
  layout "supr"
  before_filter :login_required, :except => :public_eula
  before_filter :check_permissions, :except => :public_eula
  tabs :default => :manage_eula

  def index
    @page_title = "Eula"
    @active_page = "cms_eula"
    @eula = StaticPage.where(:static_key => 'eula').first

    if @eula.blank?
      @eula = StaticPage.new
      @eula.static_key = "eula"
      @eula.save
    end
  end

  def public_eula
    @eula = StaticPage.where(:static_key => 'eula').first

    render :layout => "plus"
  end

  def edit
    @page_title = "Eula"
    @active_page = "cms_eula"
    @eula = StaticPage.where(:static_key => 'eula').first

    if @eula.blank?
      @eula = StaticPage.new
      @eula.static_key = "eula"
      @eula.save
    end
  end

  def update
    @eula = StaticPage.find(params[:id])

    if @eula.blank?
      flash[:error] = "Static Page not Found"
      redirect_to cms_eula_path
    else
      @eula.static_content = params[:eula_content]
      @eula.user_id = current_user.id
      if @eula.valid? && @eula.save
        flash[:notice] = "EULA updated"
        redirect_to cms_eula_path
      else
        flash[:error] = @eula.errors.first[1] rescue "EULA invalid"
        redirect_to cms_eula_path
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
