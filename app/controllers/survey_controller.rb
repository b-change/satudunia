class SurveyController < ApplicationController
  before_filter :login_required
  def index
    set_page_title("Surveys")
    @surveys= current_user.profile_tiers
    @survey1= current_user.profile_support
    @survey2 = current_user.profile_tier2
    @survey3 = current_user.profile_tier3
    @survey4 = current_user.profile_tier4
    @survey5 = current_user.profile_tier5
    @survey6 = current_user.profile_tier6
    @survey7 = current_user.profile_tier7
    #@news = News.where(:is_archive => false, :is_active => true).page(params[:page])
  end
end
