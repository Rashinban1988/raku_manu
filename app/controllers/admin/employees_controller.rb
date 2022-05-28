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
      # unless @employee.is_deleted
      #   @employee.learnings.update_all(is_active: true)
      #   @employee.comments.update_all(is_active: true)
      # end
      redirect_to admin_employees_path, notice: "従業員情報を更新しました"
    else
      flash[:alert] = "従業員情報の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.destroy
      redirect_to admin_employees_path, notice: "削除が完了しました"
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :telephone_number, :email, :password, :password_confirmation)
  end

end
