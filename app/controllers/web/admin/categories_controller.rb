# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = category
  end

  def update
    if category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    category.destroy
    redirect_to admin_categories_path, notice: t('.success')
  end

  private

  def category
    @category ||= Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
