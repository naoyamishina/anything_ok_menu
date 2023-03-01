class EatsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @eats = Eat.all.includes([:user, :menu]).order(created_at: :desc)
  end

  def create
    #対象メニュー特定し、eatsテーブルにユーザーid、メニューidをcreate
    @menu = Menu.find(params[:menu_id])
    current_user.eat(@menu)
    @menu.create_notification_eat!(current_user)
    redirect_to eats_path
    flash['success'] = t('eats.create.success')
  end

  def destroy
    #eatsビューからのみdelete、destroy.turbo_streamのターゲットHTML(eats/_eat)を特定するためeat変数使用
    @eat = current_user.eats.find(params[:id])
    @eat.destroy!
  end
end
