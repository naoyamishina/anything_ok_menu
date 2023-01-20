class LikesController < ApplicationController
  def create
    menu = Menu.find(params[:menu_id])
    current_user.like(menu)
    redirect_back fallback_location: menus_path, success: t('.success')
  end

  def destroy
    menu = current_user.likes.find(params[:id]).menu
    current_user.unlike(menu)
    redirect_back fallback_location: menus_path, success: t('.success')
  end
end
