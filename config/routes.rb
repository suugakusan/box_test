Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  post 'guest_login', to: "guest_sessions#create"
  get 'signup', to: 'users#new'
  
  resources :users, only: [:create]
  resources :boxposts, only: [:create, :destroy]
end
