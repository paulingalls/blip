# frozen_string_literal: true

Rails.application.routes.draw do
  resources :messages
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'pages/home'
  devise_for :users
  resources :customers
  resources :events do
    get 'closing', on: :member
    resources :bag_locations do
      member do
        get 'remind'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'
end
