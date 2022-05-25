require "test_helper"

class Admin::LearningsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_learnings_index_url
    assert_response :success
  end
end
