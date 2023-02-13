class UsersController < ApplicationController
  skip_before_action :require_login
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to menus_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show 
    @user = User.find(params[:id])
    @menus = @user.menus.includes([:likes, :tags]).order(created_at: :desc).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :gender)
  end
end
