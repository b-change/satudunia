class HomeController < ApplicationController
  layout "plus"

  def index
    @body_id = "page1"
    #default limit stepper variable
    @DefaultlimitStepper = current_group.question_default_length
    @collectionAll = Question.all.limit(@DefaultlimitStepper)
    @timeNow = Time.now
    # redirect back to admin
    if session["from_admin_login"] && !current_user.blank? && current_user.admin?
      redirect_to '/admin'
    end
  end

  def auth_popup1
    @auth_provider = params[:auth_provider]
    render :layout => "plus_notifications"
  end

  def auth_popup2
    @auth_provider = params[:auth_provider]
    render :layout => "plus_notifications"
  end

  def auth_popup3
    @auth_provider = params[:auth_provider]
    render :layout => "plus_notifications"
  end
end