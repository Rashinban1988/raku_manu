require "test_helper"

class Admin::ManualsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_manuals_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_manuals_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_manuals_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_manuals_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_manuals_edit_url
    assert_response :success
  end
end
