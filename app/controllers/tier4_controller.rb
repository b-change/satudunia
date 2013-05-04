class Tier4Controller < ApplicationController
  before_filter :login_required

  def index
    set_page_title("Tier4")

    @is_disable = !current_user.profile_tier4.nil?
    if @is_disable
      flash[:notice] = "You have already answered this profile question"
      @profile_tier4 = current_user.profile_tier4
    else
      @profile_tier4 = ProfileTier4.new
    end
  end

  def create 
    @profile_tier4 = ProfileTier4.new
    @profile_tier4.safe_update(%w[height weight body_build weight_measurement height_measurement], params[:profile_tier4])

    @profile_tier4.user_id = current_user.id 

    if @profile_tier4.save
      flash[:notice] = "Tier4 Updated"
    else
      flash[:error] = "Tier4 update Failed"
    end

    redirect_to "/survey/sample/tier5"
  end
end