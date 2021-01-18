Rails.application.routes.draw do
  root 'sessions#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'

  resources :reviews
  resources :cafes
  resources :states
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
