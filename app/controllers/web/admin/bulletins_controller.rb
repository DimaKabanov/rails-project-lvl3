# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  after_action :verify_authorized

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page])
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
