class EatsController < ApplicationController

  def index
    @eats = Eat.all.includes([:user, :menu]).order(created_at: :desc)
  end

  def create
    #対象メニュー特定し、eatsテーブルにユーザーid、メニューidをcreate
    @menu = Menu.find(params[:menu_id])
    current_user.eat(@menu)
    redirect_back_or_to(fallback_location: activities_path)
    flash['success'] = "アクティビティに登録しました"
    # flash['success'] = t('defaults.message.deleted', item: Menu.model_name.human)
  end

  def destroy
    #eatsビューからのみdelete、destroy.turbo_streamのターゲットHTML(eats/_eat)を特定するためeat変数使用
    @eat = current_user.eats.find(params[:id])
    @eat.destroy!
  end
end
