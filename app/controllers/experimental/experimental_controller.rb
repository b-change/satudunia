#@module      = experimental
#@created     = May 27 2013
#@desc        = this controller contains all the actions of experimental module

class Experimental::ExperimentalController < ApplicationController
	layout 'experiment'
  before_filter :check_age, :only => [:question_show]
  before_filter :login_required, :only=>[:ask_question,:dashboard]
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
    # add_breadcrumb "Index", 'index'
    @active_member = Membership.where(state: "active").limit(3)
    @announcements = Announcement.all
    @news = News.all
    @tags = Tag.all
    @random_tags = Tag.all.sample(4).map(&:name)
    @questions = Question.all
    # fetching data data to show in related box
    @about = StaticPage.where(:static_key => 'about').first
    @tos = StaticPage.where(:static_key => 'tos').first
    @eula = StaticPage.where(:static_key => 'eula').first
    @privacy = StaticPage.where(:static_key => 'privacy').first
    # fetching data data to show in related box
  end

  # copy of index action
  def index_experimental
    add_breadcrumb "Index1", "index1"
    @active_member = Membership.where(state: "active").limit(3)
    @announcements = Announcement.all
    @news = News.all
    @tags = Tag.all
    @random_tags = Tag.all.sample(4).map(&:name)
    @questions = Question.all
    # fetching data data to show in related box
    @about = StaticPage.where(:static_key => 'about').first
    @tos = StaticPage.where(:static_key => 'tos').first
    @eula = StaticPage.where(:static_key => 'eula').first
    @privacy = StaticPage.where(:static_key => 'privacy').first
    # fetching data data to show in related box
  end

  # action public about
  def public_about

    add_breadcrumb "About BE", (public_about_experimental_index_path).gsub("/","")
    @title = "about beingme"
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
    @questions = Question.all
  end
  #rss feed
  def rss_feed
    add_breadcrumb "RSS", 'rss'
  end
  # terms of use
  def terms
    add_breadcrumb "Privacy", "/privacy/policy"
    add_breadcrumb "Terms of Service", "terms-of-use"
    @title = "terms of use"
    @tos = StaticPage.where(:static_key => 'tos').first
    @questions = Question.all
  end
  #faq
  def faq
    @title = "faq"
    @faq = StaticPage.where(:static_key => 'tos').first
  end

  #partners action
  def partners

  end

  def terms_condition
    add_breadcrumb "Profile", "settings"
    add_breadcrumb "Participate in Research", "participate-research"
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
    add_breadcrumb "Ask Question", "ask-a-question"
    @question = Question.new(params[:question])
    Question.update_ask_question_views
  end
  #ERROR PAGE FOR EXPERIMENTAL
  def routing_error
    add_breadcrumb "404 Page not found","routing_error"
    if params[:query]!="" && params[:query].present?
      @questions_search = Question.where(:title=> /#{params[:query]}/i)
      @answers_search = Answer.where(:body=> /#{params[:query]}/i)
      @tags_search = Tag.where(:name=> /#{params[:query]}/i)
      @service_providers_search = ServiceProvider.where(:name=> /#{params[:query]}/i)
    end
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

  def comments_rss

    @question_comments_feed = (Question.order_by(:'comments.updated_at'.desc).limit(1).only(:comments).first.comments) + (Answer.order_by(:'comments.updated_at'.desc).limit(1).only(:comments).first.comments)

    respond_to do |format|
      format.atom
    end
  end
  def profile_tiers
    # debugger
    add_breadcrumb "Profile Tiers","tiers"
    set_page_title("Surveys")
    @surveys= current_user.profile_tiers
    @survey1= current_user.profile_support
    @survey2 = current_user.profile_tier2
    @survey3 = current_user.profile_tier3
    @survey4 = current_user.profile_tier4
    @survey5 = current_user.profile_tier5
    @survey6 = current_user.profile_tier6
    @survey7 = current_user.profile_tier7
  end

  def concern_about_privacy
    add_breadcrumb "concern about privacy", (concern_about_privacy_experimental_index_path).gsub("/","")
  end
  def knowledge_count
    @knowledge_base_count_views = ViewsCount.where(:type => "knowledge_base_count").first
    if @knowledge_base_count_views == nil
      ViewsCount.create(:type => "knowledge_base_count", :count => 150)
    else
      @knowledge_base_count_views.count += 1
      @knowledge_base_count_views.save
    end
    render :nothing => true
  end

  def registration
  end
end
