class SurveyController < ApplicationController
  def index
    set_page_title("News")

    @news = News.where(:is_archive => false, :is_active => true).page(params[:page])
  end
end
