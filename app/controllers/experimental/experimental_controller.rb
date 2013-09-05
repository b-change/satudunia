#@module      = experimental
#@created     = May 27 2013
#@desc        = this controller contains all the actions of experimental module

class Experimental::ExperimentalController < ApplicationController
	layout 'experiment'
  before_filter :check_age, :only => [:question_show]
  # code from the plus template in order to set current order
  subtabs :index => [[:activity, [:activity_at, :desc]],
                   [:newest, [:created_at, Mongo::DESCENDING]],
                   [:hot, [[:hotness, Mongo::DESCENDING],
                           [:views_count, Mongo::DESCENDING]]],
                   [:followers, [:followers_count, Mongo::DESCENDING]],
                   [:votes, [:votes_average, Mongo::DESCENDING]],
                   [:expert, [:created_at, Mongo::DESCENDING]]],
          :show => [[:votes, [:votes_average, Mongo::DESCENDING]], [:oldest, [:created_at, Mongo::ASCENDING]], [:newest, [:created_at, Mongo::DESCENDING]]]
  helper :votes
  # code from the plus template in order to set current order

  def index
    @active_member = Membership.where(state: "active").limit(3)
    @announcements = Announcement.all
    @news = News.all
  end

  # copy of index action
  def index_experimental
    add_breadcrumb "Index1", "index1"
    @active_member = Membership.where(state: "active").limit(3)
    @announcements = Announcement.all
    @news = News.all
  end

  # action public about
  def public_about
    
    # add_breadcrumb "About", :public_about_experimental_index_path
    
    @title = "about plus+"
  	@about = StaticPage.where(:static_key => 'about').first
    @about_user = User.find(@about.user_id) if @about.user_id?

    # fetching data data to show in related box
    @tos = StaticPage.where(:static_key => 'tos').first
    @eula = StaticPage.where(:static_key => 'eula').first
    @privacy = StaticPage.where(:static_key => 'privacy').first
    # fetching data data to show in related box

    @about_content =@about.static_content.split('P',2)
    @news = News.where(:is_archive => false, :is_active => true).page(params[:page]).order(:created_at=>:desc)
    @articles = Article.where(:is_archive => false, :is_active => true).page(params[:page]).order(:created_at=>:desc)
  end
  #rss feed
  def rss_feed
  end
  # terms of use
  def terms
    @title = "terms of use"
    @tos = StaticPage.where(:static_key => 'tos').first
  end
  #faq
  def faq
    @title = "faq"
    @faq = StaticPage.where(:static_key => 'tos').first
  end

  #partners action
  def partners

  end

  # action for admin tab
  def show_member
    @caseVarible = params[:dataSend]
    case @caseVarible
      when "newest"
        @newest_member = User.order_by(:created_at=>:desc).limit(5)
        render layout =>false
      when "active"
        @active_member = Membership.where(state: "active").limit(5)
        render layout =>false
      when "popular"
        @popular = User.order_by(:created_at=>:desc).limit(5)
        render layout =>false
      end
  end
  # community experimental
  def community
    
  end
  # before filter action
  def check_age
    @question = current_group.questions.by_slug(params[:id])

    if @question.nil?
      @question = current_group.questions.where(:slugs.in => [params[:id]]).only(:_id, :slug).first
      if @question.present?
        head :moved_permanently, :location => question_url(@question)
        return
      elsif params[:id] =~ /^(\d+)/ && (@question = current_group.questions.where(:se_id => $1).only(:_id, :slug).first)
        head :moved_permanently, :location => question_url(@question)
        return
      else
        raise Error404
      end
    end
  end

  def show_member
    
    @caseVarible = params[:dataSend]
    case @caseVarible
      when "newest"
        @newest_member = User.order_by(:created_at=>:desc).limit(3)
        render layout =>false
      when "active"
        @active_member = Membership.where(state: "active").limit(3)
        render layout =>false
      when "popular"
        @popular = User.order_by(:created_at=>:desc).limit(3)
        render layout =>false
      end
  end

  def profile
    redirect_to :controller=>'experimental/experimental', :action => 'dashboard'
  end


  def profile_settings
    
  end
  def ask_question
    @question = Question.new(params[:question]) 
  end
  #ERROR PAGE FOR EXPERIMENTAL
  def routing_error
    render :file => "#{Rails.root}/public/404.html", :status => 404
  end

  def features
     @title = "Features"
  end
  # action events
  def events
    @title="Events"   
  end
  #action crowd funding
  def crowdfunding
    @title="Crowd Funding"
  end
  #action dashboard improved by vivek
  def dashboard
    @user = current_user
    current_order = (params[:order_by].nil?)? "created_at desc" :  params[:order_by]
    # @resources = Question.all.order_by(current_order).page(params["page"]).per(15)
    # question variable
    @questions = @user.questions.all.order_by(current_order).page(params[:page]).per(15)
    # answer variable
    @answers = @user.answers.page(params[:page]).per(15)
    #following variable
    @following = ""
    respond_to do |format|
      format.html
      # format.json { render :json => @resources } 
      format.js{render "/experimental/experimental/ajax_entry"}
    end
  end
  # action dashboard ends here
  #action_social starts from here
  def social
    @title="social login"
    
  end

  #action_social ends here

  #action for dashboard
  def resources_conditional_fetch(queryData,exclude)
    # unless condition for ajax condition
    unless queryData.blank?
      case queryData
        when "newest"
          @resources = Question.all.order(:created_at=>:desc).page(params["page"]).per(15)
          @questions = @resources
        else
          #@resources = Question.all.page(params["page"]).per(15) 
          #.order_by(current_order).page(params["page"]).per(session[:per_page].blank? ? 2 : session[:per_page])
          @resources = nil
      end
    end  
  end
  

end
