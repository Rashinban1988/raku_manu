# frozen_string_literal: true

class Employee::RegistrationsController < Devise::RegistrationsController
  beforore_action :check_guest, only: :destroy

  def check_guest
    if resource.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーは削除できません"
    end
  end

  private

  def sign_up_params
    params.require(:employee).permit(:name, :telephone_number, :email, :password, :password_confirmation)
  end

end
