require 'test_helper'

class OpiControllerTest < ActionController::TestCase
  test "should get receiption" do
    get :receiption
    assert_response :success
  end

  test "should get onigokko" do
    get :onigokko
    assert_response :success
  end

  test "should get post_comment" do
    get :post_comment
    assert_response :success
  end

end
