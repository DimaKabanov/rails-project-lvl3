# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  after_action :verify_authorized

  def index
    @bulletins = Bulletin.under_moderation.page(params[:page])
    authorize [:admin, @bulletins]
  end
end
