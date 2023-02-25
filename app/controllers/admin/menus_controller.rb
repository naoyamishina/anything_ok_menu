class Admin::MenusController < Admin::BaseController
  before_action :set_menu, only: %i[edit update show destroy]

  def index
    @q = Menu.ransack(params[:q])
    @menus = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @menu.update(menu_params)
      redirect_to admin_menu_path(@menu), success: t('defaults.message.updated', item: Menu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: menu.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @menu.destroy!
    redirect_to admin_menus_path, success: t('defaults.message.deleted', item: Menu.model_name.human)
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :memo, :menu_image, :menu_image_cache)
  end
end