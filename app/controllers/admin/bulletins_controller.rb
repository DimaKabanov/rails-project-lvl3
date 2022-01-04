# frozen_string_literal: true

class Admin::BulletinsController < Admin::ApplicationController
  after_action :verify_authorized

  def index
    @bulletins = Bulletin.all
    authorize [:admin, @bulletins]
  end

  def approve
    @bulletin = bulletin
    authorize [:admin, @bulletin]
    @bulletin.approve!

    return unless @bulletin.published?

    redirect_to admin_root_path, notice: 'Bulletin was successfully published'
  end

  def reject
    @bulletin = bulletin
    authorize [:admin, @bulletin]
    @bulletin.reject!

    return unless @bulletin.rejected?

    redirect_to admin_root_path, notice: 'Bulletin was successfully rejected'
  end

  def archive
    @bulletin = bulletin
    authorize [:admin, @bulletin]
    @bulletin.archive!

    return unless @bulletin.archived?

    redirect_to admin_root_path, notice: 'Bulletin was successfully archived'
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end
end
