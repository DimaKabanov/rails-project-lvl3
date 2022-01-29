# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  after_action :verify_authorized, except: :index

  def index
    @q = Bulletin.published.order(created_at: :desc).ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page])
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
    authorize bulletin
  end

  def edit
    authorize bulletin
  end

  def update
    authorize bulletin

    if bulletin.update(bulletin_params)
      redirect_to profile_path, notice: t('.success')
    else
      render :edit
    end
  end

  def moderate
    authorize bulletin

    if bulletin.may_moderate?
      bulletin.moderate!
      redirect_to profile_path, notice: t('.success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  def archive
    authorize bulletin

    if bulletin.may_archive?
      bulletin.archive!
      redirect_to profile_path, notice: t('.success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
