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
  end
  # action public about
  def public_about
    @title = "about plus+"
  	@about = StaticPage.where(:static_key => 'about').first
    @about_content =@about.static_content.split('P',2)
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
  # questions
  def questions
     if current_user.present?
      @title = "questions"
      @tags = current_group.tags
      # code from the plus template
      unless params[:per_page].blank?
        session[:per_page] = params[:per_page]
      end
      current_order = (params[:current_order].nil?)? 'created_at' : params[:current_order]
      find_questions
      # code from the plus template
    else 
      redirect_to new_user_session_path
    end
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
    
  end

  def profile_settings
    
  end
  def ask_question
    @question = Question.new(params[:question]) 
  end
  #ERROR PAGE FOR EXPERIMENTAL
  def routing_error
    render "404", :status => 404
  end

  def features
     @title = "Features"
  end 
end
