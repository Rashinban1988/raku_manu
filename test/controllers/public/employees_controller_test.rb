require "test_helper"

class Public::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_employees_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_employees_edit_url
    assert_response :success
  end
end
