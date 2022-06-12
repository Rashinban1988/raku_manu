class Public::EmployeesController < ApplicationController
  before_action :authenticate_employee!
  before_action :ensure_current_user, {only: [:show,:edit, :update]}

  def ensure_current_user
    @employee = Employee.find(params[:id])
    if current_employee.id != @employee.id
      flash[:alert]="権限がありません"
      redirect_to("/")
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      # unless @employee.is_deleted
      #   @employee.learnings.update_all(is_active: true)
      #   @employee.comments.update_all(is_active: true)
      # end
      redirect_to employee_path, notice: "従業員情報を更新しました"
    else
      flash[:alert] = "従業員情報の更新に失敗しました"
      render :edit
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :telephone_number, :email, :password, :password_confirmation)
  end

end
