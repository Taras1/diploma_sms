require 'test_helper'

class HrControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get send_sms" do
    get :send_sms
    assert_response :success
  end

  test "should get send_sms_for_all" do
    get :send_sms_for_all
    assert_response :success
  end

end
