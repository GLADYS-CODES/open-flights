Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
root "pages#index"


namespace :api do
  namespace :v1 do
    resources :airlines, param: :slug
    resources :reviews, only: [ :create, :destroy]
    
    
  end
  end

  # Defines a route that will match any HTTP GET request to the path "/pages/*"

  get '*path', to: 'pages#index', via: :all
end
