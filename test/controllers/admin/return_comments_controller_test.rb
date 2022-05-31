require "test_helper"

class Admin::ReturnCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_return_comments_create_url
    assert_response :success
  end
end
