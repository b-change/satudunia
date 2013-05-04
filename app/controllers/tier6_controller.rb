class Tier6Controller < ApplicationController
  before_filter :login_required

  def index
    set_page_title("Tier6")

    @is_disable = !current_user.profile_tier6.nil?
    if @is_disable
      flash[:notice] = "You have already answered this profile question"
      @profile_tier6 = current_user.profile_tier6
    else
      @profile_tier6 = ProfileTier6.new
    end
  end

  def create
    @profile_tier6 = ProfileTier6.new
    @profile_tier6.safe_update(%w[preferred_role preferred_into], params[:profile_tier6])

    @profile_tier6.user_id = current_user.id

    if @profile_tier6.save
      flash[:notice] = "Tier6 Updated"
    else
      flash[:error] = "Tier6 update Failed"
    end

    redirect_to "/survey/sample/tier7"
  end
end