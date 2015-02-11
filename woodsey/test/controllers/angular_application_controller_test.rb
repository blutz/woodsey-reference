require 'test_helper'

class AngularApplicationControllerTest < ActionController::TestCase
  test "should get load" do
    get :load
    assert_response :success
  end

end
