class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
    else
      redirect_to menu_path(@comment.menu), danger: t('defaults.message.not_created', item: Comment.model_name.human)
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
