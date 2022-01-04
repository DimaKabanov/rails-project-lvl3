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

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to (request.referer || root_path),
                alert: t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
  end
end
