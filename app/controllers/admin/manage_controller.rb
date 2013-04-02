class Admin::ManageController < ApplicationController
  before_filter :login_required, :except => [:dashboard]
  before_filter :check_permissions, :except => [:dashboard, :edit_card]
  layout "supr"
  tabs :dashboard => :dashboard,
       :properties => :properties,
       :content => :content,
       :actions => :actions,
       :stats => :stats,
       :widgets => :widgets

  subtabs :properties => [[:general, "general"],
                          [:rewards, "rewards"],
                          [:constrains, "constrains"],
                          [:theme, "theme"],
                          [:domain, "domain"]]
  subtabs :content => [[:question_prompt, "question_prompt"],
                       [:question_help, "question_help"],
                       [:head_tag, "head_tag"],
                       [:head, "head"], [:footer, "footer"],
                       [:top_bar, "top_bar"]]

  subtabs :social => [[:post_to_twitter, "post_to_twitter"],
                     [:ask_from_twitter, "ask_from_twitter"],
                     [:facebook_app, "facebook_app"],
                     [:twitter_account, "twitter_account"]]
  subtabs :invitations => [[:invite, "invite"],
                     [:invitations, "invitations"]]

  def dashboard
    @page_title = "Dashboard"
    @active_page = "dashboard"
    
    session["from_admin_login"] = false if !current_user.blank?

    if current_user.nil? || current_user.blank?
      render :layout => "supr_login_page"
    end
  end

  def edit_card
    if params[:group_id]
      @group = Group.find(params[:group_id])
    else
      @group = current_group
    end
    return unless current_user.owner_of?(@group)
    render :layout => 'invitations'
  end

  def properties
    @active_page = "site_config"
    @active_subtab ||= "general"
    @page_title = "Site Config"
  end

  def appearance
    @page_title = "Appearance"
  end

  def actions
  end

  def stats
  end

  def domain
  end

  def content
    @activeTabClass = params[:tab];
    @active_subtab ||= "head_tag"
    @page_title = "Content"
    unless @group.has_custom_html
      flash[:error] = t("global.permission_denied")
      redirect_to domain_url(:custom => @group.domain, :controller => "manage",
                             :action => "properties", :tab => "constrains")
    end
  end

  def social
    @page_title = "Social Media"
    @active_subtab ||= "post_to_twitter"
    @active_page = "features_social"
  end

  def invitations
    @active_subtab ||= "invite"
    @page_title = "Invitations"
    @invitation = Invitation.new
    @active_page = "user_invitations"
  end

  def access
    @page_title = "Access"
    @active_page = "user_access"
  end

  def close_group
    @page_title ="Close group"
  end
  #newly action added for reward
  def rewards
    @page_title ="Rewards"
    @active_subtab ||= "rewards"
    @active_page ="rewards"
  end

  protected
  def check_permissions
    @group = current_group

    if @group.nil?
      redirect_to groups_path
    elsif !current_user.owner_of?(@group) && !current_user.admin?
      flash[:error] = t("global.permission_denied")
      redirect_to domain_url(:custom => @group.domain)
    end
  end
end
