class EatsController < ApplicationController

  def index
    @eats = Eat.all.includes([:user, :menu]).order(created_at: :desc)
  end

  def create
    @menu = Menu.find(params[:menu_id])
    current_user.eat(@menu)
    redirect_to menus_path
  end
end
