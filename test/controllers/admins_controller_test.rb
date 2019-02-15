require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  test "should get list_users" do
    get :list_users
    assert_response :success
  end

end
