# frozen_string_literal: true

class ProfilesController < ApplicationController
  after_action :verify_authorized

  def index
    @bulletins = Bulletin.where(creator: current_user).page(params[:page])
    authorize [:profile, @bulletins]
  end
end
