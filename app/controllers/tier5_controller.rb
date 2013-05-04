class Tier5Controller < ApplicationController
  before_filter :login_required

  def index
    set_page_title("Tier5")

    @is_disable = !current_user.profile_tier5.nil?
    if @is_disable
      flash[:notice] = "You have already answered this profile question"
      @profile_tier5 = current_user.profile_tier5
    else
      @profile_tier5 = ProfileTier5.new
    end
  end

  def create
    @profile_tier5 = ProfileTier5.new
    @profile_tier5.safe_update(%w[occupation religion is_drink_alcohol is_smoker music books movies television other_interest], params[:profile_tier5])

    @profile_tier5.user_id = current_user.id

    if @profile_tier5.save
      flash[:notice] = "Tier5 Updated"
    else
      flash[:error] = "Tier5 update Failed"
    end

    redirect_to "/survey/sample/tier6"
  end
end