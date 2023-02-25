class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    @menu = comment.menu
    if comment.save
      redirect_to menu_path(comment.menu), success: t('defaults.message.created', item: Comment.model_name.human)
      @menu.create_notification_comment!(current_user)
    else
      redirect_to menu_path(comment.menu), danger: t('defaults.message.not_created', item: Comment.model_name.human)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(menu_id: params[:menu_id])
  end
end
