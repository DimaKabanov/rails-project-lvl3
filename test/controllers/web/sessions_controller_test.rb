# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_path
    assert_response :success
  end

  test 'should login as admin' do
    admin = users(:admin)

    post session_url, params: { user: { email: admin.email } }

    assert_redirected_to controller: 'web/admin/home', action: 'index'
  end

  test 'should destroy session' do
    admin = users(:admin)

    post session_url, params: { user: { email: admin.email } }

    delete session_path

    assert_redirected_to controller: 'web/bulletins', action: 'index'
  end
end
