# frozen_string_literal: true

Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/github', to: 'sessions#create', as: 'github_omniauth_authorize'

  resource :session, only: %i[new create destroy]
  resource :user, only: %i[new]

  root 'welcome#index'
end
