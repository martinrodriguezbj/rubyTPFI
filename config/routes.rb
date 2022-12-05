Rails.application.routes.draw do
  resources :turns
  patch '/turns/:id/attended', to: 'turns#attended'
  get 'turns/:id/attend', to: 'turns#attend', as: 'attend_turn'
  
  resources :users
  get '/index_client', to: 'users#index_client', as: 'index_client'
  resources :banks
  resources :sessions
  get '/profiles', to: 'profiles#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
