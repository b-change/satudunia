class Tier7Controller < ApplicationController
  before_filter :login_required

  def index
    set_page_title("Tier7")

    @is_disable = !current_user.profile_tier7.nil?
    if @is_disable
      flash[:notice] = "You have already answered this profile question"
      @profile_tier7 = current_user.profile_tier7
    else
      @profile_tier7 = ProfileTier7.new
    end
  end

  def create
    @profile_tier7 = ProfileTier7.new
    @profile_tier7.safe_update(%w[first_diagnosis sex_hiv relationship_hiv disclosure family_hiv work_hiv discrimination disclosure_stigma acceptance treatment humorous_odd future_life], params[:profile_tier7])

    @profile_tier7.user_id = current_user.id

    if @profile_tier7.save
      flash[:notice] = "Tier7 Updated"
    else
      flash[:error] = "Tier7 update Failed"
    end

    redirect_to survey_user_path(current_user.id)
  end
end