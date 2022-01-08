# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    get '/auth/:provider/callback', to: 'omniauth#create', as: 'callback_auth', via: :all
    post '/auth/github', to: 'omniauth#create', as: 'github_omniauth_authorize'

    resource :session, only: %i[new create destroy]
    resource :user, only: %i[new]
    resources :bulletins, only: %i[index show new create edit update] do
      patch 'archive', on: :member
      patch 'to_moderate', on: :member
    end
    get 'profile', to: 'profiles#index'

    namespace :admin do
      root 'home#index'
      resources :categories
      resources :bulletins do
        patch 'approve', on: :member
        patch 'reject', on: :member
        patch 'archive', on: :member
      end
    end
  end
end
