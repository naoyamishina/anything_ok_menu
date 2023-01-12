class MenusController < ApplicationController
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
      render :new
    end
  end

  def show
    @menu = Menu.find(params[:id])
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :memo)
  end
end
