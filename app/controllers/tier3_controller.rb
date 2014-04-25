class Tier3Controller < ApplicationController
  before_filter :login_required

  def index
    set_page_title("Tier3")
    get_profile_support
  end

  def create 
    @profile_tier3 = ProfileTier3.new
    @profile_tier3.safe_update(%w[relationship_status is_partner_known is_known_partner_hiv], params[:profile_tier3])

    @profile_tier3.user_id = current_user.id 

    if @profile_tier3.save
      flash[:notice] = "Tier3 Updated"
    else
      flash[:error] = "Tier3 update Failed"
    end
    if request.xhr?
      redirect_to tier3_index_path
    else
      redirect_to "/survey/sample/tier4"
    end
    # redirect_to "/survey/sample/tier4"
  end

  def tier3_index
    get_profile_support
    render :layout=>false
  end

  private
  def get_profile_support    
    @is_disable = !current_user.profile_tier3.nil?
    if @is_disable
      flash[:notice] = "You have already answered this profile question"
      @profile_tier3 = current_user.profile_tier3
    else
      @profile_tier3 = ProfileTier3.new
    end
  end
end