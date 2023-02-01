Rails.application.routes.draw do
  resources :localities
  resources :turns
  patch '/turns/:id/attended', to: 'turns#attended'
  get 'turns/:id/attend', to: 'turns#attend', as: 'attend_turn'
  get '/past_turns', to: 'turns#past_turns'
  get '/future_turns', to: 'turns#future_turns'
  resources :users
  get '/index_client', to: 'users#index_client', as: 'index_client'
  resources :banks
  patch '/schedules/:id/updateSchedule', to: 'schedules#updateSchedule'
  get 'schedules/:id/editSchedule', to: 'schedules#editSchedule', as: 'editSchedule_schedule'
  resources :sessions
  get '/profiles', to: 'profiles#show'
  get '/profiles/edit', to: 'profiles#edit', as: 'edit_profile'
  patch '/profiles', to: 'profiles#update'

  #ruta donde una persona puede registrarse
  get '/signup', to: 'users#newCliente', as: 'signup'
  post '/signup', to: 'users#createCliente'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    #root a banks
    root 'banks#index'
end
