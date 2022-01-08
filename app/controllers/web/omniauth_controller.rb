# frozen_string_literal: true

class Web::OmniauthController < Web::ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_or_create_by_auth(request.env['omniauth.auth'])

    if user
      sign_in user
      redirect_to root_path, notice: t('messages.welcome_user', user: user.email)
    else
      redirect_to new_session_path, notice: t('messages.inсorrect_user')
    end
  end
end
