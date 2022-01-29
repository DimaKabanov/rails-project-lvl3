# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include AuthConcern

  around_action :switch_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale

    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
