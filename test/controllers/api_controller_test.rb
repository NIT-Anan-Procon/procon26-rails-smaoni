require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get roomin" do
    get :roomin
    assert_response :success
  end

end
