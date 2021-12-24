# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_or_create_by_auth(request.env['omniauth.auth'])

    if user
      sign_in user
      redirect_to root_path
    else
      redirect_to new_session_path, notice: t('.inсorrect')
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
