Rails3Plus::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations", :invitations => 'users/invitations', :omniauth_callbacks => "users/omniauth_callbacks" }, :path_names => { :sign_in => 'login' }
  resources :users

  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    #get '/users/facebook' => 'registrations#facebook'
  end

  devise_scope :user do
    get "join", :to => "registrations#join", :as => "join"
    get "deactivate", :to => "registrations#deactivate", :as => "deactivate_registration"
    get "facebook/register", :to => "registrations#facebook", :as => "facebook_registration"
    get "twitter/register", :to => "registrations#twitter", :as => "twitter_registration"
    get "google/register", :to => "registrations#google", :as => "google_registration"
    get "linkedin/register", :to => "registrations#linkedin", :as => "linkedin_registration"
  end

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id))(.:format)'
end
