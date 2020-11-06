Rails.application.routes.draw do
  root 'events#index'
  namespace :admin do
    root to: 'base#index'
    resources :users
    resources :events
  end
  devise_for :users
  resources :users
  resources :events do
    resources :attendances
    resources :event_picture, only: [:create]
  end
end