Rails.application.routes.draw do
  root 'events#index'
  devise_for :users
  resources :users
  resources :events do
    resources :attendances
    resources :event_picture, only: [:create]
  end
end