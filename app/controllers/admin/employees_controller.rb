class Admin::EmployeesController < ApplicationController

  def index
    @employees = Employee.all
    @employee = Employee.new
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
      unless @employee.is_deleted
        @employee.learnings.update_all(is_active: true)
        @employee.comments.update_all(is_active: true)
      end
      redirect_to admin_employees_path, notice: "従業員情報を更新しました"
    else
      flash[:alert] = "在職・退職を選んでください"
      render :edit
    end
  end

  private

  def employees_params
    params.require(:employee).permit(:name, :telephone_number, :email, :password, :password_confirmation)
  end

end
