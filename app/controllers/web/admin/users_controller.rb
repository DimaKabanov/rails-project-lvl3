# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all.page(params[:page])
    authorize [:admin, @users]
  end

  def edit
    @user = user
    authorize [:admin, @user]
  end

  def update
    @user = user
    authorize [:admin, @user]

    if @user.update(user_params)
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
