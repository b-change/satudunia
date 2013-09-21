class NewsController < ApplicationController

  def index
    set_page_title("News")

    @news = News.where(:is_archive => false, :is_active => true).page(params[:page])
  end

  def show
    @news = News.by_slug(params[:id])

    if @news.nil? || !@news.is_active
      flash[:error] = "News not found"
      redirect_to news_index_path
    else
      set_page_title(@news.news_title)
    end
  end

  def rating
    @news = News.find(params[:id])
    @news.rate params[:score] ,current_user
    @news.save
    render :nothing => true
  end
end