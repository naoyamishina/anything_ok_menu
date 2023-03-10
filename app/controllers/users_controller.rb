class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show]
  
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
    @menus = @user.menus.includes([:bookmarks, :tags, :comments, :eats]).order(created_at: :desc).page(params[:page])
  end

  def bookmarks
    @user = User.find(params[:user_id])
    @bookmark_menus = @user.bookmark_menus.includes([:user, :bookmarks, :tags, :eats, :comments]).order(created_at: :desc).page(params[:page])
  end

  def eats
    @user = User.find(params[:user_id])
    @eat_menus = @user.eats.includes([:user, :menu]).order(created_at: :desc).page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :gender)
  end
end
