class Public::ManualsController < ApplicationController
  def index
    @manuals = Manual.all
  end

  def show
    @manual = Manual.find(params[:id])
    @manuals = Manual.all
    @comment = @manual.comments.new
    @comments = @manual.comments.all
    @learning = @manual.learnings.new
    @learnings = @manual.learnings.all
    p "--------------------------------------------------"
    p Learning
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.employee_id = current_employee.id
    if @comment.save
      redirect_to public_manual_path(@comment.manual_id), notice: "質問を投稿しました"
    else
      @manual = @comment.manual
      @manuals = Manual.all
      @comments = Comment.all
      flash[:alert] = "質問の投稿に失敗しました"
      render :show
      # redirect_to public_manual_path, alert: "質問の投稿に失敗しました"
    end
  end

  #習得したボタン（初回）と習得切替への振り替え
  def learnings_create
    @learning = Learning.new(learning_params)
    @learning.employee_id = current_employee.id
    if @learning.save
      redirect_to public_manual_path(@learning.manual_id)
    elsif
      @learning = Learning.new(learning_params)
      @learning.employee_id = current_employee.id
      @learning.is_learned = false
      @learning.update(learning_params)
      redirect_to public_manual_path(@learning.manual_id), notice: "テスト中"
    else
      @manual = Manual.find(params[:id])
      @manuals = Manual.all
      @comment = @manual.comments.new
      @comments = @manual.comments.all
      @learnings = @manual.learnings.all
      flash[:alert] = "習得切替に失敗しました"
      render :show
    end
  end

  def is_unlearned
    @learning = Learning.find(params[:id])
    if @learning.is_learned == true
      @learning.is_learned = false
      @learning.update(learning_params)
      redirect_to public_manual_path(@learning.manual_id)
    else
      @manual = Manual.find(params[:id])
      @manuals = Manual.all
      @comment = @manual.comments.new
      @comments = @manual.comments.all
      @learnings = @manual.learnings.all
      flash[:alert] = "習得切替に失敗しました"
      render :show
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
