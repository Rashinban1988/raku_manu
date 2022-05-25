require "test_helper"

class Public::ManualsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_manuals_index_url
    assert_response :success
  end

  test "should get show" do
    get public_manuals_show_url
    assert_response :success
  end
end
