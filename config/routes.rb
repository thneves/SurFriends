Rails.application.routes.draw do
  resources :users

  root 'static_pages#home'
  get 'static_pages/about'
  get 'signup' => "users#new"
end
