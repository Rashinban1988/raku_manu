class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
    @return_comment = @comment.return_comments.new
    @return_comments = @comment.return_comments.all
    @employee = @comment.employee
    @manual = @comment.manual
  end

  def employee_comments
    @employee = Employee.find(params[:id])
    @comments = @employee.comments.all
  end

  def employee_manual_comment
    @comment = Comment.find(params[:id])
    @manual = Manual.find(@comment.manual_id)
    @return_comment = ReturnComment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to admin_comments_path, notice: "コメントを削除しました"
    else
      @comment = Comment.find(params[:id])
      @return_comments = @comment.return_comments.all
      flash[:alert] = "コメントの削除に失敗しました"
      render :index
    end
  end

end
