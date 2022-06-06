class Public::LearningsController < ApplicationController
  before_action :authenticate_employee!
  before_action :ensure_current_user, {only: [:show,:edit, :update]}

  def ensure_current_user
    @employee = Employee.find(params[:id])
    if current_employee.id != @employee.id
      flash[:alert]="権限がありません"
      redirect_to("/")
    end
  end

  def employee_index
    @employee = Employee.find(params[:id])
    @manual_learnings = @employee.learnings.all
  end

  def create
    @manual_learning = Learning.new(employee_id: current_employee.id, manual_id: params[:manual_id])
    @manual_learning.save
    redirect_to public_manual_path(params[:manual_id])
  end

  def destroy
    @manual_learning = Learning.find_by(employee_id: current_employee.id, manual_id: params[:manual_id])
    @manual_learning.destroy
    redirect_to public_manual_path(params[:manual_id])
  end

# 　習得スタッフ一覧用
  def manual_is_learned
    @manual = Manual.find(params[:id])
    @learnings = @manual.learnings.all
  end

  # 習得、未収得の切り替え
  def is_learned
    @learning = Learning.find(params[:id])
    if @learning.is_learned == true
      @learning.is_learned = false
    else
      @learning.is_learned = true
    end
    if @learning.update(learning_params)
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
    params.require(:learning).permit(:employee_id, :manual_id, :is_learned )
  end


end
