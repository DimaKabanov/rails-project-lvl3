# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).page(params[:page])
  end

  def publish
    if bulletin.may_publish?
      bulletin.publish!
      redirect_to admin_root_path, notice: t('.success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  def reject
    if bulletin.may_reject?
      bulletin.reject!
      redirect_to admin_root_path, notice: t('.success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  def archive
    if bulletin.may_archive?
      bulletin.archive!
      redirect_to admin_root_path, notice: t('.success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end
end
