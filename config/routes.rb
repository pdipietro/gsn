Rails.application.routes.draw do

  root                     'landing_pages#home'#, defaults: { :format => "js"}, :remote => :true
  get    'home'      =>    'landing_pages#home', defaults: { :format => "js"}, :remote => :true
  get    'about'     =>    'static_pages#about', defaults: { :format => "js"}, :remote => :true
  get    'contacts'  =>    'static_pages#contacts', defaults: { :format => "js"}, :remote => :true
  get    'help'      =>    'static_pages#help', defaults: { :format => "js"}, :remote => :true
  get    'privacy'   =>    'static_pages#privacy', defaults: { :format => "js"}, :remote => :true
  get    'terms'     =>    'static_pages#terms', defaults: { :format => "js"}, :remote => :true

  get    'admin'     =>    'sessions#loginAdmin'

  get    'login'     =>    'sessions#new', defaults: { :format => "js"}, :remote => :true
  post   'login'     =>    'sessions#create', defaults: { :format => "js"}, :remote => :true
  get    'signup'    =>    'subjects#new', defaults: { :format => "js"}, :remote => :true
  delete 'logout'    =>    'sessions#destroy', defaults: { :format => "js"}, :remote => :true

  #get    'profile'   =>    'user_profiles#edit', defaults: { :format => "js"}, :remote => :true

#  get    'password_resets/new'
#  get    'password_resets/edit.

  post    'accept'   =>      'cookielaws#accept', defaults: { :format => "js"}, :remote => :true
  post    'refuse'   =>      'cookielaws#refuse', defaults: { :format => "js"}, :remote => :true
  post    'privacy'  =>      'cookielaws#privacy', defaults: { :format => "js"}, :remote => :true
  resources :mail_collectors,                    defaults: { :format => "js"}, :remote => :true

#  resources :account_activations, only: [:edit], defaults: { :format => "js"}, :remote => :true
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update], defaults: { :format => "js"}, :remote => :true

  resources :subjects,            constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true,  except: [:destroy, :show]
  resources :subjects,                                             defaults: { :format => "js"}, :remote => :true,  only: [:show, :create]

# administrative resources

  resources :languages,           constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :social_networks,     constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true,  except: [:destroy]

  resources :posts,               constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :groups,              constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true,  except: [:show]

  resources :landing_pages,       constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true,  except: [:destroy]
  resources :tags,                constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :tests,               constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :images,              constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :media_managers,      constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :subject_profiles,    constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :post_comments,       constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :discussions,         constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true
  resources :discussion_comments, constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true, except: [:new]

  get       'groups/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'groups#list', :as => :groups_list, defaults: { :format => "js"}, :remote => :true
  get       'group/:id/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>    'groups#list_one', :as => :group_list, defaults: { :format => "js"}, :remote => :true
  get       'groups/:id(/:filter)'                                      =>    'groups#show', :as => :groups_show, defaults: { :format => "js"}, :remote => :true

  get       'social_networks/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'social_networks#list', :as => :social_networks_list, defaults: { :format => "js"}, :remote => :true
  get       'social_network/:id/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'social_networks#list_one', :as => :social_network_list, defaults: { :format => "js"}, :remote => :true

  get       'subjects/list/:class/:object_id/:rel(/:from_page(/:limit(/:subject(/:deep))))'  =>   'subjects#list', :as => :subjects_list, defaults: { :format => "js"}, :remote => :true

  get       'discussions/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'discussions#list', :as => :discussions_list, defaults: { :format => "js"}, :remote => :true
  get       'discussions/add(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'discussions#add', :as => :discussions_add, defaults: { :format => "js"}, :remote => :true

  get       'posts/list/:social_uuid(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'posts#list', :as => :posts_list, defaults: { :format => "js"}, :remote => :true
  get       'post/:id/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>    'posts#list_one', :as => :post_list, defaults: { :format => "js"}, :remote => :true


  get       'discussion_comment/new(/:parent_class/:parent_uuid)'            =>    'discussion_comments#new', :as => :new_discussion_comment, defaults: { :format => "js"}, :remote => :true

#  get       'post/list(/:filter(/:from_page(/:limit(/:subject(/:deep)))))'  =>   'post#list', :as => :posts_list, defaults: { :format => "js"}, :remote => :true

# These new routes support passing the belongs_to object

#  post       'discussions/create/:belongs_to_class/:belongs_to_id'          =>   'discussions#create',         :as => :discussions_create, defaults: { :format => "js"}, :remote => :true
#  post       'discussion_comments/create/:belongs_to_class/:belongs_to_id'  =>   'discussion_comments#create', :as => :discussion_comment_create, defaults: { :format => "js"}, :remote => :true
#  post       'post_comments/create/:belongs_to_class/:belongs_to_id'        =>   'post_comments#create',       :as => :post_comment_create, defaults: { :format => "js"}, :remote => :true

# These are miscellaneous routes

  post      'likes/:id/:class/:relationship' =>    'likes#edit',           :as => :onerel, defaults: { :format => "js"}, constraints: AuthConstraint.new, :remote => :true
  get       'likes'                          =>    'likes#dummy',          :as => :dummy, constraints: AuthConstraint.new
  get       'searches'                       =>    'likes#search',         :as => :searches, constraints: AuthConstraint.new
#  post      'show_image/:img'                =>    'likes#show_image',     :as => :show_image, defaults: { :format => "js"}, constraints: AuthConstraint.new, :remote => :true
#  post      'show_document/:doc'             =>    'likes#show_document',  :as => :show_document, defaults: { :format => "js"}, constraints: AuthConstraint.new, :remote => :true
#  post      'show_content/:img'              =>    'likes#show_content',   :as => :show_content, defaults: { :format => "js"}, constraints: AuthConstraint.new, :remote => :true
  post      'show_image/:img'                =>    'likes#show_image',     :as => :show_image, defaults: { :format => "js"}, :remote => :true
  post      'show_document/:doc'             =>    'likes#show_document',  :as => :show_document, defaults: { :format => "js"}, :remote => :true
  post      'show_content/:img'              =>    'likes#show_content',   :as => :show_content, defaults: { :format => "js"}, :remote => :true
  get       'hide(/:id)'                     =>    'likes#hide',           :as => :hide, defaults: { :format => "js"}, :remote => :true
  get       '/media_managers/list/'          =>    'media_managers#list',  :as => :image_list #, defaults: { :format => "js"}, :remote => :true
 # get       'user_profiles'                 =>    'user_profiles#edit',    :as => :edit, constraints: AuthConstraint.new, defaults: { :format => "js"}, :remote => :true

end
