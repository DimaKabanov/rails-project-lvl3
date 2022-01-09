# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  after_action :verify_authorized

  def index
    @q = Bulletin.published.order(created_at: :desc).ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page])
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
      redirect_to profile_path, notice: t('.success')
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
      redirect_to profile_path, notice: t('.success')
    else
      render :edit
    end
  end

  def moderate
    @bulletin = bulletin
    authorize @bulletin
    @bulletin.moderate!

    return unless @bulletin.under_moderation?

    redirect_to profile_path, notice: t('.success')
  end

  def archive
    @bulletin = bulletin
    authorize @bulletin
    @bulletin.archive!

    return unless @bulletin.archived?

    redirect_to profile_path, notice: t('.success')
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
