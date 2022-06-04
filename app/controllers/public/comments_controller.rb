class Public::CommentsController < ApplicationController

  def index
    if params[:keyword].present?
      @comments = Comment.where("is_desolved LIKE ? ", "%#{params[:keyword]}%").order(id: :DESC)
      @keyword = params[:keyword]
    else
      @keyword = Comment.all
      @comments = Comment.all.order(id: :DESC)
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to public_manual_path(@comment.manual), notice: "質問内容を編集しました"
    else
      @comment = Comment.find(params[:id])
      flash[:alert] = "編集に失敗しました"
      render :show
    end
  end

  def employee_comments
    @employee = Employee.find(params[:id])
    @return_comments = ReturnComment.all
    @comments = @employee.comments.all.order(id: :DESC)
  end

  def employee_comments_show
    @comment = Comment.find(params[:id])
    @return_comment = @comment.return_comments.new
    @return_comments = @comment.return_comments.all
    @employee = @comment.employee
    @manual = @comment.manual
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
      flash[:alert] = "質問の投稿に失敗しました"
      render :show
    end
  end

  #解決、未解決の切り替え
  def is_desolved
    @comment = Comment.find(params[:id])
    if @comment.is_desolved == true
      @comment.is_desolved = false
    else
      @comment.is_desolved = true
    end
    if @comment.update(comment_params)
      redirect_to public_show_comments_employee_path
    else
      @comment = Comment.find(params[:id])
      @return_comment = @comment.return_comments.new
      @return_comments = @comment.return_comments.all
      @employee = @comment.employee
      @manual = @comment.manual
      render :employee_comments_show
    end
  end

  def return_comments_create
    @return_comment = ReturnComment.new(return_comment_params)
    @return_comment.employee_id = current_employee.id
    if @return_comment.save
      redirect_to public_show_comments_employee_path(@return_comment.comment_id), notice: "質問への返信を投稿しました"
    else
      @comment = Comment.find(params[:id])
      @return_comment = @comment.return_comments.new
      @return_comments = @comment.return_comments.all
      @employee = @comment.employee
      @manual = @comment.manual
      render :employee_comments_show, alert: "質問への返信に失敗しました"
    end
  end

  # 検索機能
  def search
    if params[:keyword].present?
      @comments = Comment.where("is_desolved LIKE ", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @keyword = Comment.all
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:employee_id, :manual_id, :comment, :is_desolved )
  end

  def return_comment_params
    params.require(:return_comment).permit(:comment_id, :employee_id, :return_comment )
  end

end
