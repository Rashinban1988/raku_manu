class Admin::CommentsController < ApplicationController
  def index
    @employee = Employee.all
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

end
