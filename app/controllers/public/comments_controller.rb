class Public::CommentsController < ApplicationController

  def employee_comments
    @employee = Employee.find(params[:id])
    @return_comments = ReturnComment.all
    @comments = @employee.comments.all
  end

  def employee_comments_show
    @employee = Employee.find(params[:id])
    p "----------------------------------------------------------------------------------"
    p @employee
    @comment = Comment.find(params[:id])
    @return_comment = @comment.return_comments.new
    @return_comments = @comment.return_comments.all
    @comments = @employee.comments.all
  end

  def employee_manual_comment
    @comment = Comment.find(params[:id])
    @manual = Manual.find(@comment.manual_id)
    @return_comment = ReturnComment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to public_manual_path, notice: "質問を投稿しました"
    else
      # @manual = Manual.find(params[:id])
      # @comment = Comment.new
      # @comments = Comment.all
      flash[:alert] = "質問の投稿に失敗しました"
      render :show
      # redirect_to public_manual_path, alert: "質問の投稿に失敗しました"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:employee_id, :manual_id, :comment, :is_desolved )
  end

  def return_comment_params
    params.require(:return_comment).permit(:comment_id, :return_comment )
  end

end
