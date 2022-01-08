# frozen_string_literal: true

require 'test_helper'

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_with_admin(users(:three))
  end

  # test 'should get index' do
  #   get admin_categories_path
  #   assert_response :success
  # end

  test 'should get new' do
    get new_admin_category_path
    assert_response :success
  end
end
