Rails.application.routes.draw do
  devise_for :users
  namespace :creator do
    resources :assets
  end

  namespace :api do
    namespace :v1 do
      resources :admins, only: [] do
        get 'creators_earnings', to: 'admins#creators_earnings'
      end
    end
  end
  namespace :customer do
    # Custom route for customer to view assets
    resources :assets, only: [:index]  # Or you can add show, create, etc.
  end
  resources :purchase_items, only: [:create, :destroy, :show] do
    collection do
      post :quick_add
    end
  end

  resources :check_outs, only: [:index, :update]


  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
