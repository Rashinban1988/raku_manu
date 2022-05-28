class Public::ManualsController < ApplicationController
  def index
    @manuals = Manual.all
  end

  def show
    @manual = Manual.find(params[:id])
    @manuals = Manual.all
    @comment = @manual.comments.new
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.employee_id = current_employee.id
    p "----------------------------------------------------------------------------------"
    p @comment
    if @comment.save
      redirect_to public_manual_path(@comment.manual_id), notice: "質問を投稿しました"
    else
      p @comment.errors
      @manual = @comment.manual
      @manuals = Manual.all
      @comments = Comment.all
      flash[:alert] = "質問の投稿に失敗しました"
      render :show
      # redirect_to public_manual_path, alert: "質問の投稿に失敗しました"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:manual_id, :comment, :is_desolved)
  end

end
