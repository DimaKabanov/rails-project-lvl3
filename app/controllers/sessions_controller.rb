# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(user_params)

    if user&.admin?
      sign_in user
      redirect_to admin_root_path, notice: t('messages.welcome_admin')
    else
      redirect_to new_session_path, notice: t('messages.inсorrect_admin')
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: t('messages.goodby')
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
