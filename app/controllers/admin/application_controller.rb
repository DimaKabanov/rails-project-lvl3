# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :admin_not_authorized

  private

  def admin_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to (request.referer || root_path),
                alert: t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
  end
end
