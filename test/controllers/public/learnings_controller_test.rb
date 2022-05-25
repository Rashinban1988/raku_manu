require "test_helper"

class Public::LearningsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_learnings_show_url
    assert_response :success
  end

  test "should get congratulation" do
    get public_learnings_congratulation_url
    assert_response :success
  end

  test "should get update" do
    get public_learnings_update_url
    assert_response :success
  end
end
