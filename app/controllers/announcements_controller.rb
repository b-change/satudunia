class AnnouncementsController < ApplicationController
  before_filter :login_required, :except => [:hide,:announce,:show]
  before_filter :check_permissions, :except => [:hide,:announce,:show]

  layout "supr"
  tabs :default => :announcements
  before_filter :set_breadcrumb ,:except => [:index,:announce]

  layout "experiment", :only => [:announce]
  # GET /announcements
  # GET /announcements.json
  def index
    @page_title = "Announcements"
    @active_page = "features_announcement"
    @announcements = current_group.announcements.order_by(["updated_at", "desc"]).page(params["page"])

    @announcement = Announcement.new

    respond_to do |format|
      format.html # index.html.haml
      format.js
      format.json  { render :json => @announcements }
    end
  end

  # POST /announcements
  # POST /announcements.json
  def create

    @announcement = Announcement.new
    @announcement.safe_update(%w[message only_anonymous announcement_image], params[:announcement])
    @announcement.user_id = current_user.id
    @announcement.starts_at = build_datetime(params[:announcement], "starts_at")
    @announcement.ends_at = build_datetime(params[:announcement], "ends_at")
    @announcement.group = current_group

    respond_to do |format|
      if @announcement.valid? && @announcement.save
        if params[:announcement][:announcement_image]
          Jobs::Images.async.generate_announcement_thumbnails(@announcement.id).commit!
        end
        flash[:notice] = I18n.t("announcements.create.success")
        format.html { redirect_to admin_announcements_path }
        format.json  { render :json => @announcement, :status => :created, :location => @announcement }
      else
        @announcements = current_group.announcements.order_by(["updated_at", "desc"]).page(params["page"])
        format.html { render :action => "index" }
        format.json  { render :json => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement = current_group.announcements.by_slug(params[:id])
    @announcement.destroy
    flash[:notice] = "Announcement deleted"
    respond_to do |format|
      format.html { redirect_to(admin_announcements_path) }
      format.json  { head :ok }
    end
  end

  def hide
    session[:announcement_hide_time] = Time.zone.now

    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"] ? :back : root_path }
      format.js { render :json => {:status => "ok"} }
    end
  end

  def announce
    add_breadcrumb "Announcements", "announcements"
    @announcements = Announcement.all.page(params["page"]).per(6)

    # render :layout => "experiment"
    # @announcement = Announcement.where(:only_anonymous=> false ).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    
    #@announcement = Announcement.find(params[:id])
    @announcement = Announcement.by_slug(params[:id])
    @related_announcement = Announcement.all.order('articles.impressions_count DESC').limit(6)
    add_breadcrumb @announcement.message, @announcement.slug
    render :layout => "experiment"
  end

  def rating
    @announcement = Announcement.find(params[:id])
    @announcement.rate params[:score] ,current_user
    @announcement.save    
    render :layout =>false
  end

  protected
  def check_permissions
    if current_group.nil?
      redirect_to root_path
    elsif !current_user.owner_of?(current_group) && !current_user.admin?
      flash[:error] = t("global.permission_denied")
      redirect_to domain_url(:custom => current_group.domain)
    end
  end

  def set_breadcrumb
    add_breadcrumb "Announcements", :announcements_path
  end
end
