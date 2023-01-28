class MenusController < ApplicationController
  before_action :set_menu, only: [:edit, :update, :destroy]

  def index
    @menus = Menu.all.includes(:user).order(created_at: :desc)
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = current_user.menus.build(menu_params)
    if @menu.save
      redirect_to menus_path, success: t('defaults.message.created', item: Menu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Menu.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @menu = Menu.find(params[:id])
    @comment = Comment.new
    @comments = @menu.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @menu.update(menu_params)
      redirect_to @menu, success: t('defaults.message.updated', item: Menu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Menu.model_name.human)
      render :edit
    end
  end

  def destroy
    @menu.destroy!
    redirect_to menus_path, success: t('defaults.message.deleted', item: Menu.model_name.human), status: :see_other
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :memo, :menu_image, :menu_image_cache)
  end

  def set_menu
    @menu = current_user.menus.find(params[:id])
  end
end
