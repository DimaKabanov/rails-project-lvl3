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
      redirect_to admin_categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize [:admin, @category]
  end

  def update
    @category = Category.find(params[:id])
    authorize [:admin, @category]

    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy; end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
