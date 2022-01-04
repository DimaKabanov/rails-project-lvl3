# frozen_string_literal: true

class Admin::HomeController < Admin::ApplicationController
  after_action :verify_authorized

  def index
    @bulletins = Bulletin.under_moderation
    authorize [:admin, @bulletins]
  end
end
