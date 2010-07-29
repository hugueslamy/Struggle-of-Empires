require 'test_helper'

class PropositionsControllerTest < ActionController::TestCase
  setup do
    @proposition = propositions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:propositions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposition" do
    assert_difference('Proposition.count') do
      post :create, :proposition => @proposition.attributes
    end

    assert_redirected_to proposition_path(assigns(:proposition))
  end

  test "should show proposition" do
    get :show, :id => @proposition.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @proposition.to_param
    assert_response :success
  end

  test "should update proposition" do
    put :update, :id => @proposition.to_param, :proposition => @proposition.attributes
    assert_redirected_to proposition_path(assigns(:proposition))
  end

  test "should destroy proposition" do
    assert_difference('Proposition.count', -1) do
      delete :destroy, :id => @proposition.to_param
    end

    assert_redirected_to propositions_path
  end
end
