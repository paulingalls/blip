# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'pages/home'
  devise_for :users
  resources :messages
  resources :customers do
    resources :text_chats
  end
  resources :events do
    get 'closing', on: :member
    get 'complete', on: :member
    resources :bag_locations do
      member do
        get 'remind'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'
end
