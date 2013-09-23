class BadgesController < ApplicationController
  before_filter :track_pageview
  # before_filter :login_required ,:only=>[:index]
  layout "experiment"

  tabs :default => :badges

  # GET /badges
  # GET /badges.xml
  def index
    add_breadcrumb "Badges", (badges_path).gsub("/","") 
    @badge_comments = BadgeComment.arrange(:order => :created_at)
    @badge_comment = BadgeComment.new
    @badge_comments_count = BadgeComment.all
    
    conditions = {group_id: current_group.id, for_tag: params[:tab] == "tags"}
    if params[:filter].present? && params[:filter] != "all"
      conditions[:type] = params[:filter]
    end

    @badges = Badge.collection.master.group({key: [:token, :type, :for_tag], initial: {count: 0}, reduce: "function(doc, prev) { prev.count += 1}", cond: conditions}).map do |attrs|
      Badge.new(attrs)
    end

    if params[:tab] == "general" || params[:tab].nil?
      Badge.TOKENS.each do |token|
        if @badges.detect{|b| b.token == token}.nil?
          badge = Badge.new(:token => token)
          @badges << badge
        end
      end
    end

    if params[:tab].present?
      Badge.TOKENS.each do |token|
        if @badges.detect{|b| b.token == token}.nil?
          badge = Badge.new(:token => token)
          @badges << badge
        end
      end
    end
    
    if params[:badge_search] 
      @badges = []
      Badge.TOKENS.each do |token|
        if token.include?(params[:badge_search])
          badge = Badge.new(:token => token)
          @badges << badge
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @badges }
      # view for ajax data
      format.js
    end
  end

  # GET /badges/1
  # GET /badges/1.xml
  def show
    @badge = Badge.new(:token => params[:id])
    @badge[:type] ||= (@badge.type || params[:type] || "bronze")
    if Badge.type_of(params[:id]).nil?
      @badge.for_tag = true
    end

    @badges = Badge.where(:token => @badge.token, :group_id => current_group.id, :$or => [{:type => @badge.type}, {for_tag: true}]).
                    order_by(:created_at.desc).only([:user_id]).page(params["page"])

    user_ids = @badges.map { |b| b.user_id }
    @users = User.find(user_ids)

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @badge.to_json }
    end
  end
end
