Rails.application.routes.draw do
  resources :turns
  resources :users
  resources :banks
  resources :sessions
  get '/profiles', to: 'profiles#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
