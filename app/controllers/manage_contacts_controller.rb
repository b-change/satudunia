class ManageContactsController < ApplicationController
  layout "supr"
  before_filter :login_required
  before_filter :check_permissions

  def index
    @page_title = "Contact Us"
    @active_page = "manage_contact"

    @contact = StaticPage.where(:static_key => 'contact').first

    if @contact.blank?
      @contact = StaticPage.new(:latitude => "1.28668", :longitude => "103.853607", :street_address => "3 Fullerton Rd, Singapore")
      @contact.static_key = "contact"
      @contact.save
    end
  end

  def update
    @contact = StaticPage.find(params[:id])

    if @contact.nil? || @contact.static_key != "contact"
      flash[:error] = "Contact Us record not found"
      redirect_to manage_contact_us_path
    else
      @contact.safe_update(%w[latitude longitude street_address], params)
      @contact.user_id = current_user.id

      if @contact.save
        flash[:notice] = "Map Updated!"
        redirect_to manage_contact_us_path
      else
        flash[:error] = "Update Error, #{@contact.errors.first[1]}"
        redirect_to manage_contact_us_path
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