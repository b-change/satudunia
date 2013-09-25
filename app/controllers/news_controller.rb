class NewsController < ApplicationController
  before_filter :set_breadcrumb ,:except => [:index]
  def index
    add_breadcrumb "News", "news"
    set_page_title("News")

    @news = News.where(:is_archive => false, :is_active => true).page(params[:page])
  end

  def show
    @news = News.by_slug(params[:id])
    add_breadcrumb @news.news_title, @news.slug

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
  def set_breadcrumb
    add_breadcrumb "News", news_index_path
  end
end