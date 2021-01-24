Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root 'sessions#home'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'

  resources :reviews
  resources :shops do
    resources :reviews, only: [:new, :index, :edit]
  end
  resources :states
  resources :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
