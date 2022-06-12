class Public::ManualsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @manuals = Manual.all.order(id: :DESC)
    if params[:keyword].present?
      @genres = Genre.where("name LIKE ? ", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @keyword = Genre.all
      @genres = Genre.all
    end
  end

  def show
    @manual = Manual.find(params[:id])
    @manuals = Manual.all
    @comment = @manual.comments.new
    @comments = @manual.comments.all.order(id: :DESC)
    @learning = @manual.learnings.new
    @learnings = @manual.learnings.all
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.employee_id = current_employee.id
    if @comment.save
      redirect_to manual_path(@comment.manual_id), notice: "質問を投稿しました"
    else
      redirect_to manual_path(@comment.manual_id), alert: "質問の投稿に失敗しました"
    end
  end

  def search
    if params[:keyword].present?
      @genres = Genre.where("name LIKE ", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @keyword = Genre.all
    end
  end

    private

  def comment_params
    params.require(:comment).permit(:manual_id, :comment, :is_desolved)
  end

  def learning_params
    params.require(:learning).permit(:employee_id, :manual_id, :is_learned)
  end

end
