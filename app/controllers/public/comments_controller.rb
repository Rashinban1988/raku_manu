class Public::CommentsController < ApplicationController

  def employee_comments
    @employee = Employee.find(params[:id])
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
    params.require(:comment).permit(:employee_id, :manual_id, :comment, :is_desolved)
  end

end
