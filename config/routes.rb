Rails.application.routes.draw do
  # Internationalization of the routes
  filter :locale

  devise_for :admins, :controllers => {:sessions => "admins/devise/sessions" }
  devise_for :creators, :controllers => {:registrations=> "creators/devise/registrations", :sessions => "creators/devise/sessions"}
  devise_for :users, :controllers => {:sessions => "users/devise/sessions", :invitations => 'users/devise/invitations' }

  resources :admins, only: :show do
    resources :badges, :controller => "admins/badges"
    resources :creators, only: [:index, :destroy], :controller => "admins/creators"
    resources :users, only: [:index, :destroy], :controller => "admins/users"
    resources :games, only: [:index, :destroy], :controller => "admins/games"
  end
  resources :creators, only: [:show, :edit, :update] do
    resources :games, :controller => "creators/games", except: :index do
      resources :rules, :controller => "creators/rules", except: :show
    end
  end
  resources :users, only: [:show, :edit, :update] do
    resources :games, :controller => "users/games", only: :show
    resources :rules, :controller => "users/rules" do
      member do
        post 'mark_pending', as: :rule_pending
        post 'mark_complete', as: :rule_complete, :controller => "creators/rules"
      end
    end
  end

  get 'about'=> "home#about"
  root to: "home#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
