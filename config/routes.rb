ENV["MAGENT_WEB_PATH"] = "/magent"
require 'magent_web'

#ENV["BUGHUNTER_PATH"] = "/errors"
#require 'bug_hunter'

Rails.application.routes.draw do
  
  get "survey/index"

  devise_for(:users, :path => '/',
             :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             :controllers => {:registrations => 'users', :omniauth_callbacks => "multiauth/sessions"}) do
  end
  match '/groups/:group_id/check_custom_domain' => 'groups#check_custom_domain',
  :as => 'check_custom_domain'
  match '/groups/:group_id/reset_custom_domain' => 'groups#reset_custom_domain',
   :method => :post, :as => 'reset_custom_domain'
  match '/connect' => 'users#social_connect', :method => :get, :as => :social_connect
  match '/invitations/accept' => 'invitations#accept', :method => :get, :as => :accept_invitation
  match '/disconnect_twitter_group' => 'groups#disconnect_twitter_group', :method => :get
  match '/group_twitter_request_token' => 'groups#group_twitter_request_token', :method => :get
  match 'confirm_age_welcome' => 'welcome#confirm_age', :as => :confirm_age_welcome
  match '/change_language_filter' => 'welcome#change_language_filter', :as => :change_language_filter
  match '/register' => 'users#create', :as => :register
  match '/signup' => 'users#new', :as => :signup
  match '/plans' => 'doc#plans', :as => :plans
  match '/chat' => 'doc#chat', :as => :chat
  match '/shapado_feedback' => 'welcome#feedback', :as => :feedback
  match '/switch_mobile_view' => 'welcome#switch_mobile_view'
  match '/feedback' => 'welcome#fake_feedback'
  match '/send_feedback' => 'welcome#send_shapado_feedback', :as => :send_feedback
  match '/send_shapado_feedback' => 'welcome#send_feedback', :as => :send_feedback
  #match '/profile/settings' => 'users#edit', :as => :settings
  match '/tos' => 'manage_terms#public_terms', :as => :tos
  match '/privacy' => 'manage_privacy#public_privacy', :as => :privacy
  match '/widgets/embedded/:id' => 'widgets#embedded', :as => :embedded_widget
  match '/suggestions' => 'users#suggestions', :as => :suggestions
  match '/activities' => 'activities#index', :as => :activities
  match '/contact' => 'contact#index', :as => :contact
  match '/activities/:id' => 'activities#show', :as => :activity, :method => :get

  match '/update_stripe' => 'invoices#webhook', :method => :post

  match '/eula' => 'manage_eulas#public_eula'
  match '/privacy-policy' => 'manage_privacy#public_privacy'
  #match '/terms-of-use' => 'manage_terms#public_terms'
  #match '/about' => 'manage_abouts#public_about'
  #match '/faq' => 'manage_faqs#public_faq'
  match '/first-auth/:auth_provider' => 'home#auth_popup1'
  match '/second-auth/:auth_provider' => 'home#auth_popup2'
  match '/third-auth/:auth_provider' => 'home#auth_popup3'

  get "mobile/index"

  match '/users/auth/:provider' => 'users#auth', :as => :auth_users

  match '/facebook' => "facebook#index", :as => :facebook, :method => :any
  match '/facebook/enable_page' => 'facebook#enable_page', :as => :enable_page_facebook

  mount MagentWeb.app => ENV["MAGENT_WEB_PATH"]
#  mount BugHunter.app => ENV["BUGHUNTER_PATH"]

  match '/facts' => redirect("/")
  match '/users/:id/:slug' => redirect("/users/%{slug}"), :as => :user_se_url, :id => /\d+/
  resources :users do
    collection do
      get :autocomplete_for_user_login
      post :connect
      get :follow_tags
      get :unfollow_tags
      get :leave
      get :join
      post :connect
      get :new_password
    end

    member do
      get :feed
      get :expertise
      get :preferred
      get :by_me
      get :contributed
      post :unfollow
      post :follow
      get :answers
      get :follows
      get :activity
      get :survey
    end
  end
  # match 'towns' => 'towns#index'
  get 'faq' =>"manage_faqs#public_faq"
  get 'experimental/about' => "manage_abouts#experimental_about"
  get 'question/:question_id/votesup/:vote_up'=>"votes#create",:as=>:vote_question_up
  get 'question/:question_id/votesdown/:vote_down'=>"votes#create",:as=>:vote_question_down
  resources :countquestions
  resources :badges
  resources :news_letter, :path=>'/newsletter'

  resources :searches, :path => "search", :as => "search"
  
  resources :contact do
    collection do
      post :send_contact_us
    end
  end
  
  # resources :service_providers, :except => [:show], :path=>'services-map'
  get '/services-map/:id/:slug' => "service_providers#show", :as=>:service_map_provider
  resources :news
  resources :polls

  resources :pages do
    member do
      get :js
      get :css
    end
  end

  resources :announcements do
    collection do
      get :hide
    end
  end

  resources :imports do
    collection do
      post :send_confirmation
    end
  end

  get '/questions/:id/:slug' => 'questions#show', :as => :se_url, :id => /\d+/
  post '/questions/:id/start_reward' => "reward#start", :as => :start_reward
  get '/questions/:id/close_reward' => "reward#close", :as => :close_reward

  match '/answers(.format)' => 'answers#index', :as => :answers

  scope('questions') do
    resources :tags, :constraints => { :id => /\S+/ }
  end

  match 'questions/unanswered' => redirect("/questions?unanswered=1")

  match 'question/:id' => 'questions#show', :as => :question
  #match 'questions/ask-a-question' => "questions#new", :as => :new_question

  # resources :questions, :except => [:show, :new] do

  #   resources :votes
  #   resources :flags
  #   collection do
  #     get :tags_for_autocomplete
  #     get :related_questions
  #     get 'page/:page', :action => :index
  #     match '/:filter' => 'questions#index', :as => :filtered, :constraints => { :filter => /all|unanswered|by_me|feed|preferred|contributed|expertise/ }
  #   end

  #   member do
  #     get :solve
  #     get :unsolve
  #     get :flag
  #     get :follow
  #     get :unfollow
  #     get :history
  #     get :revert
  #     get :diff
  #     get :move
  #     put :move_to
  #     get :retag
  #     put :retag_to
  #     get :remove_attachment
  #     get :twitter_share
  #   end

  #   resources :comments do
  #     resources :votes
  #   end

  #   resources :answers do
  #     resources :votes
  #     resources :flags
  #     member do
  #       get :favorite
  #       get :unfavorite
  #       get :flag
  #       get :history
  #       get :diff
  #       get :revert
  #     end

  #     resources :comments do
  #       resources :votes
  #     end
  #   end

  #   resources :close_requests
  #   resources :open_requests
  # end
  get '/search_ajax' => 'searches#search_ajax'
  post '/question_search'=>'questions#question_search#index'

  match 'questions/tags/:tags' => 'tags#show', :as => :question_tag
  match 'questions/tagged/:tags' => redirect { |env, req| "/questions/tags/#{req.params[:tags].gsub(' ', '+')}" }, :tags => /.+/ #support se url

  resources :groups do
    collection do
      get :autocomplete_for_group_slug
      get :add_to_facebook
      post :join
    end

    member do
      get :allow_custom_ads
      get :disallow_custom_ads
      post :close
      post :update_card
      get :accept

      post :upgrade
      post :downgrade
      post :set_columns
    end
  end

  resources :invitations do
    member do
      post :revoke
      post :resend
    end
  end

  resources :invoices do
    member do
      get :success
    end
    collection do
      get :auto_update
      get :upcoming
    end
  end

  resources :survey
  resources :tier_sample
  match '/survey/sample/tier-sample' => 'tier_sample#index'

  scope '/survey/sample/' do
  resources :tier1

  resources :tier2

  resources :tier3

  resources :tier4

  resources :tier5

  resources :tier6

  resources :tier7
  end

  scope '/manage' do
    resources :members
    resources :service_categories
    resources :providers
    resources :manage_news
    resources :manage_polls
    resources :manage_terms
    resources :manage_abouts
    resources :manage_eulas
    resources :manage_privacy
    resources :manage_faqs
    resources :manage_contacts
  end
  
  scope '/admin' do
    resources :widgets do
      member do
        post :move
      end
    end
    resources :themes do
      member do
        get :remove_bg_image
        put :apply
        get :ready
        get :download
      end
      collection do
        post :import
      end
    end
    resources :constrains_configs,:path => "requirements"
  end

  scope '/manage', :as => 'manage' do
    controller 'admin/manage' do
      match 'dashboard' => :dashboard
      match 'edit_card' => :edit_card
      match 'properties' => :properties
      match 'theme' => :theme
      match 'actions' => :actions
      match 'stats' => :stats
      match 'reputation' => :reputation
      match 'invitations' => :invitations
      match 'access' => :access
    end
  end
  scope '/admin', :as => 'manage' do
    controller 'admin/manage' do
      match 'social' => :social
      match 'appearance' => :appearance
      match 'close_group' => :close_group, :path => "close-group"
      match 'content' => :content
      match 'rewards' => :rewards
    end
  end
  match '/manage/properties/:tab' => 'admin/manage#properties', :as => :manage_properties_tab
  match '/admin/index' => 'admin/manage#dashboard', :as => :admin_dashboard
  match '/admin/config' => 'admin/manage#properties', :as => :admin_config
  match '/admin/service-providers' => 'service_categories#index', :as => :service_providers_index
  match '/admin/service-providers/providers' => 'providers#index', :as => :manage_service_providers
  match '/admin/news/list' => 'manage_news#index'
  match '/admin/faq' => 'manage_faqs#index'
  match '/admin/polls' => 'manage_polls#index'
  match '/admin/contact-us' => 'manage_contacts#index', :as => :manage_contact_us
  match '/admin' => 'admin/manage#dashboard'
  match '/admin/cms/terms-of-use' => 'manage_terms#index', :as => :cms_terms
  match '/admin/cms/about-us' => 'manage_abouts#index', :as => :cms_abouts
  match '/admin/cms/eula' => 'manage_eulas#index', :as => :cms_eula
  match '/admin/cms/privacy-policy' => 'manage_privacy#index', :as => :cms_privacy

  match '/admin/cms/edit/terms-of-use' => 'manage_terms#edit', :as => :cms_edit_terms
  match '/admin/cms/edit/about-us' => 'manage_abouts#edit', :as => :cms_edit_abouts
  match '/admin/cms/edit/eula' => 'manage_eulas#edit', :as => :cms_edit_eula
  match '/admin/cms/edit/privacy-policy' => 'manage_privacy#edit', :as => :cms_edit_privacy

  match '/admin/user-access' => 'admin/manage#access', :as => :admin_user_access
  match '/admin/members' => 'members#index', :as => :admin_members
  match '/admin/invitations' => 'admin/manage#invitations', :as => :admin_manage_invitations

  match '/admin/flags' => 'flags#admin_index', :as => :admin_manage_flags

  namespace :moderate do
    resources :questions do
      collection do
        get :flagged
        get :to_close
        get :to_open
        post :manage
      end
      member do
        get :banning
        put :ban

        get :closing
        put :close
        get :opening
        put :open
      end
    end
    resources :answers do
      collection do
        post :manage
      end
      member do
        get :banning
        put :ban
      end
    end
    resources :users
  end

   # experimetal routes
  scope :module => "experimental" do
    resources :experimental, :path => "/" do
      collection do
        get :index,:path=>"/index"
        get :public_about,:path=>"/about"
        get :rss_feed,:path=>"rss"
        get :terms, :path=>"terms-of-use"
        get :faq
        get :questions
        get :partners
        get :show_member
        get '/questions/ask-a-question' => 'experimental#ask_question', :as => :ask_question
        get 'questions/:id' => 'experimental#question_show', :as => :question_show
        get :community
        get 'services-map' => 'experimental#service_providers_show', :as => :service_providers_show
        get :profile
        get :profile_settings, :path=> "/profile/settings"
        # experimental routes
        get "*a", :to => "experimental#routing_error"
      end
    end
  end 

  resources :questions, :except => [:show, :new] do

    resources :votes
    resources :flags
    collection do
      get :tags_for_autocomplete
      get :related_questions
      get 'page/:page', :action => :index
      match '/:filter' => 'questions#index', :as => :filtered, :constraints => { :filter => /all|unanswered|by_me|feed|preferred|contributed|expertise/ }
    end

    member do
      get :solve
      get :unsolve
      get :flag
      get :follow
      get :unfollow
      get :history
      get :revert
      get :diff
      get :move
      put :move_to
      get :retag
      put :retag_to
      get :remove_attachment
      get :twitter_share
    end

    resources :comments do
      resources :votes
    end

    resources :answers do
      resources :votes
      resources :flags
      member do
        get :favorite
        get :unfavorite
        get :flag
        get :history
        get :diff
        get :revert
      end

      resources :comments do
        resources :votes
      end
    end

    resources :close_requests
    resources :open_requests
  end


  match '/moderate' => 'moderate/questions#index'
#   match '/search' => 'searches#index', :as => :search
  match '/about' => 'groups#show', :as => :about
  root :to => 'experimental/experimental#index'
  #match '/:controller(/:action(/:id))'
  match '*a', :to => 'public_errors#routing'
end
