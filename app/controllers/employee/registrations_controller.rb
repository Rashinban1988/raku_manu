# frozen_string_literal: true

class Employee::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update destroy]

  def check_guest
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーの編集・削除できません"
    end
  end

  private

  def sign_up_params
    params.require(:employee).permit(:name, :telephone_number, :email, :password, :password_confirmation)
  end

end
