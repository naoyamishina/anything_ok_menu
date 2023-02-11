class MenusController < ApplicationController
  before_action :set_menu, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: %i[index show search_tag]

  def index
    @q = Menu.ransack(params[:q])
    @menus = @q.result(distinct: true).includes([:user, :likes, :tags]).order(created_at: :desc).page(params[:page])
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = current_user.menus.build(menu_params)
    @tag_list = params[:menu][:tag_name]
    @tag = @tag_list.gsub(" ", "").split(',').uniq
    if @menu.save
      @menu.save_tag(@tag)
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
    @menu_tags = @menu.tags
  end

  def edit
    @tag_list = @menu.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:menu][:tag_name].gsub(" ", "").split(',').uniq
    if @menu.update(menu_params)
      @old_relations = MenuTag.where(menu_id: @menu.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @menu.save_tag(tag_list)
      redirect_to @menu, success: t('defaults.message.updated', item: Menu.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Menu.model_name.human)
      render :edit
    end
  end

  def destroy
    @menu.destroy!
    redirect_back_or_to(fallback_location: menus_path, status: :see_other)
    flash['success'] = t('defaults.message.deleted', item: Menu.model_name.human)
  end

  def likes
    @q = current_user.like_menus.ransack(params[:q])
    @like_menus = @q.result(distinct: true).includes([:user, :likes]).order(created_at: :desc).page(params[:page])
  end

  def mymenus
    @q = current_user.menus.ransack(params[:q])
    @my_menus = @q.result(distinct: true).includes([:user]).order(created_at: :desc).page(params[:page])
  end

  def search_tag
    @q = Menu.ransack(params[:q])
    # 検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 検索されたタグに紐づく投稿を表示
    @menus = @tag.menus.page(params[:page]).per(10)
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :memo, :menu_image, :menu_image_cache, :eat_at)
  end

  def set_menu
    @menu = current_user.menus.find(params[:id])
  end
end
