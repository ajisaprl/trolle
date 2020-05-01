Rails.application.routes.draw do
  devise_for :users

  resources :tasks

  root 'pages#home'

  get 'about' => 'pages#about'
end
