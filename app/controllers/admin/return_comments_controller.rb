class Admin::ReturnCommentsController < ApplicationController

  def create
    @return_comment = ReturnComment.new(return_comment_params)
    @return_comment.admin_id = current_admin.id
    p "----------------------------------------------------------"
    p @return_comment
    if @return_comment.save
      redirect_to admin_comment_path(@return_comment.comment_id), notice: "質問への返信を投稿しました"
    else
      @comment = Comment.find(params[:id])
      @return_comment = @comment.return_comments.new
      @return_comments = @comment.return_comments.all
      @employee = @comment.employee
      @manual = @comment.manual
      render :comments/show, alert: "質問への返信に失敗しました"
    end
  end

  private

  def return_comment_params
    params.require(:return_comment).permit(:admin_id, :comment_id, :return_comment )
  end

end
