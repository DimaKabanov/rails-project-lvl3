# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    get '/auth/:provider/callback', to: 'auth#callback', as: :callback_auth, via: :all
    post '/auth/:provider', to: 'auth#request', as: :auth_request

    resource :session, only: %i[new create destroy]
    resource :user, only: %i[new]
    resources :bulletins, only: %i[index show new create edit update] do
      patch 'archive', on: :member
      patch 'moderate', on: :member
    end
    get 'profile', to: 'profiles#index'

    namespace :admin do
      root 'home#index'
      resources :categories
      resources :users, only: %i[index edit update]
      resources :bulletins do
        patch 'publish', on: :member
        patch 'reject', on: :member
        patch 'archive', on: :member
      end
    end
  end
end
