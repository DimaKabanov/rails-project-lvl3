# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get new_session_path
    assert_response :success
  end
end
