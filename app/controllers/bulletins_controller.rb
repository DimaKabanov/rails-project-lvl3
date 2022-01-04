# frozen_string_literal: true

class BulletinsController < ApplicationController
  after_action :verify_authorized

  def index
    @bulletins = Bulletin.published.order(created_at: :desc)
    authorize @bulletins
  end

  def new
    authorize Bulletin
    @bulletin = current_user.bulletins.build
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      render :new
    end
  end

  def show
    @bulletin = bulletin
    authorize @bulletin
  end

  def edit
    @bulletin = bulletin
    authorize @bulletin
  end

  def update
    @bulletin = bulletin
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to bulletin_path(@bulletin)
    else
      render :edit
    end
  end

  def to_moderate
    @bulletin = bulletin
    authorize @bulletin
    @bulletin.to_moderate!

    return unless @bulletin.under_moderation?

    redirect_to profile_path, notice: 'Bulletin was successfully submitted for moderation'
  end

  def archive
    @bulletin = bulletin
    authorize @bulletin
    @bulletin.archive!

    return unless @bulletin.archived?

    redirect_to profile_path, notice: 'Bulletin was successfully archived'
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :body, :category_id, :image)
  end
end
