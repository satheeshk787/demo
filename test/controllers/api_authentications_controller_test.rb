require 'test_helper'

class ApiAuthenticationsControllerTest < ActionController::TestCase
  setup do
    @api_authentication = api_authentications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_authentications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_authentication" do
    assert_difference('ApiAuthentication.count') do
      post :create, api_authentication: { key: @api_authentication.key, name: @api_authentication.name }
    end

    assert_redirected_to api_authentication_path(assigns(:api_authentication))
  end

  test "should show api_authentication" do
    get :show, id: @api_authentication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_authentication
    assert_response :success
  end

  test "should update api_authentication" do
    patch :update, id: @api_authentication, api_authentication: { key: @api_authentication.key, name: @api_authentication.name }
    assert_redirected_to api_authentication_path(assigns(:api_authentication))
  end

  test "should destroy api_authentication" do
    assert_difference('ApiAuthentication.count', -1) do
      delete :destroy, id: @api_authentication
    end

    assert_redirected_to api_authentications_path
  end
end
