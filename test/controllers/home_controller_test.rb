# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get :index' do
    sign_in users(:one)
    get root_path
    assert_response :success
  end

  test 'should not redirect unauthrorized user' do
    sign_out users(:one)
    get root_path
    assert_response :success
  end
end
