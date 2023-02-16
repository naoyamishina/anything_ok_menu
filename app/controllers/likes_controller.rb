class LikesController < ApplicationController
  def create
    #対象メニュー特定し、likesテーブルにユーザーid、メニューidをcreate
    @menu = Menu.find(params[:menu_id])
    current_user.like(@menu)
  end

  def destroy
    #menuビューからのみdelete、destroy.turbo_streamのターゲットHTML(menus/_like)を特定するためmenu変数使用
    @menu = current_user.likes.find(params[:id]).menu
    current_user.unlike(@menu)
  end
end
