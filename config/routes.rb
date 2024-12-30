# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do

  mount MissionControl::Jobs::Engine, at: "/jobs"

  resources :chats, only: :create

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :itineraries do
    get :run, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  # authenticate :user, ->(user) { user.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  
end
