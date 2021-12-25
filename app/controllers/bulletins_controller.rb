# frozen_string_literal: true

class BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def new
    @bulletin = current_user.bulletins.build
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_path(@bulletin), notice: t('.success')
    else
      render :new
    end
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def update
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.update(bulletin_params)
      redirect_to bulletin_path(@bulletin)
    else
      render :edit
    end
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.destroy
      redirect_to root_path
    else
      redirect_to bulletin_path(@bulletin)
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :body, :category_id, :image)
  end
end
