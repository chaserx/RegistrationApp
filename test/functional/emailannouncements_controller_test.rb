require 'test_helper'

class EmailannouncementsControllerTest < ActionController::TestCase
  setup do
    @emailannouncement = emailannouncements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emailannouncements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emailannouncement" do
    assert_difference('Emailannouncement.count') do
      post :create, emailannouncement: @emailannouncement.attributes
    end

    assert_redirected_to emailannouncement_path(assigns(:emailannouncement))
  end

  test "should show emailannouncement" do
    get :show, id: @emailannouncement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emailannouncement
    assert_response :success
  end

  test "should update emailannouncement" do
    put :update, id: @emailannouncement, emailannouncement: @emailannouncement.attributes
    assert_redirected_to emailannouncement_path(assigns(:emailannouncement))
  end

  test "should destroy emailannouncement" do
    assert_difference('Emailannouncement.count', -1) do
      delete :destroy, id: @emailannouncement
    end

    assert_redirected_to emailannouncements_path
  end
end
