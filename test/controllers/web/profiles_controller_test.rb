# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'guest cant get index' do
    get profile_path
    assert_response :redirect
  end

  test 'signed user should get index' do
    sign_in_as_user users(:one)

    get profile_path
    assert_response :success
  end
end
