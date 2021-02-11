Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  resources :sessions, only: %w[new create destroy]

  root 'static_pages#home'
  get 'about' => "static_pages#about"
  get 'signup' => "users#new"
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
