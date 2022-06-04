class Admin::ReturnCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comment = Comment.find(params[:id])
    @return_comments = @comment.return_comments.all
    @employee = @comment.employee.id
    @manual = @comment.manual.id
  end

  def destroy
    @return_comment = ReturnComment.find(params[:id])
    @comment = @return_comment.comment_id
    if @return_comment.destroy
      redirect_to admin_comment_path, notice: "コメントを削除しました"
    else
      @comment = Comment.find(params[:id])
      @return_comments = @comment.return_comments.all
      flash[:alert] = "コメントの削除に失敗しました"
      render :index
    end
  end

end
