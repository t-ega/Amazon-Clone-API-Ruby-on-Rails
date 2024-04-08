Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index create destroy show]
      resources :authors, only: %i[index create]

      get "auth/signup", to: "auth#create"
      get "auth/login", to: "auth#signin"
      get "auth/logout", to: "auth#signout"

    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
