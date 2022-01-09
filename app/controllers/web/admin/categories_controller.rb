# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  after_action :verify_authorized

  def index
    @categories = Category.all.page(params[:page])
    authorize [:admin, @categories]
  end

  def new
    authorize [:admin, Category]
    @category = Category.new
  end

  def create
    authorize [:admin, Category]
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = category
    authorize [:admin, @category]
  end

  def update
    @category = category
    authorize [:admin, @category]

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = category
    authorize [:admin, @category]

    @category.destroy
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
