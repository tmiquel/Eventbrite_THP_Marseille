# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pictures/create'
  devise_for :users, path_prefix: 'my'
  resources :users
  resources :events do
    resources :attendances
    resources :pictures, only:  [:create]
  end
  root to: 'events#index'
  resources :charges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

