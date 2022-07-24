require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get :index" do
    get home_:index_url
    assert_response :success
  end
end
