# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def edit
    @user = user
  end

  def update
    if user.update(user_params)
      redirect_to admin_users_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
