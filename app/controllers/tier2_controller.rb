class Tier2Controller < ApplicationController
  before_filter :login_required

  def index
    set_page_title("Tier2")
    get_profile_support
  end

  def create
    @profile_tier2 = ProfileTier2.new
    @profile_tier2.safe_update(%w[is_hiv_positive date_last_test date_first_diagnosed country_first_diagnosed state_first_diagnosed city_first_diagnosed date_last_check_up is_antiretroviral date_antiretroviral myth_about_hiv odd_about_hiv country_regular_check_up state_regular_check_up city_regular_check_up], params[:profile_tier2])

    @profile_tier2.user_id = current_user.id

    if @profile_tier2.save
      flash[:notice] = "Tier2 Updated"
    else
      flash[:error] = "Tier2 update Failed: #{@profile_tier2.errors.first[1]}"
    end
    if request.xhr?
      redirect_to tier2_index_path
    else
      redirect_to "/survey/sample/tier3"
    end
    # redirect_to "/survey/sample/tier3"
  end
  
  def tier2_index
    get_profile_support
    render :layout=>false
  end

  private
  def get_profile_support
    @is_disable = !current_user.profile_tier2.nil?
    if @is_disable
      flash[:notice] = "You have already answered this profile question"
      @profile_tier2 = current_user.profile_tier2
    else
      @profile_tier2 = ProfileTier2.new
    end
  end
end