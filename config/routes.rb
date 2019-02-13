# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path_prefix: 'my'
  resources :users
  resources :attendances
  resources :events
  root to: 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
