class BookmarksController < ApplicationController
  def create
    #対象メニュー特定し、bookmarksテーブルにユーザーid、メニューidをcreate
    @menu = Menu.find(params[:menu_id])
    current_user.bookmark(@menu)
    @menu.create_notification_bookmark!(current_user)
  end

  def destroy
    #menuビューからのみdelete、destroy.turbo_streamのターゲットHTML(menus/_bookmark)を特定するためmenu変数使用
    @menu = current_user.bookmarks.find(params[:id]).menu
    current_user.unbookmark(@menu)
  end
end
