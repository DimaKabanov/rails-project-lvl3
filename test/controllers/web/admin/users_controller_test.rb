# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as_admin users(:admin)
    @attrs = {
      name: Faker::Name.name
    }
  end

  test 'should get index' do
    get admin_users_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_user_path @user
    assert_response :success
  end

  test 'should update user' do
    patch admin_user_path @user, params: { user: @attrs }

    assert_redirected_to controller: 'web/admin/users', action: 'index'

    @user.reload
    assert { @attrs[:name] == @user.name }
  end
end
