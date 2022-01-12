# frozen_string_literal: true

require 'test_helper'

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    sign_in_as_admin users(:admin)
    @attrs = {
      name: Faker::Lorem.characters(number: 4)
    }
  end

  test 'should get index' do
    get admin_categories_path
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_category_path @category
    assert_response :success
  end

  test 'should create new category' do
    post admin_categories_path, params: { category: @attrs }

    assert_redirected_to controller: 'web/admin/categories', action: 'index'

    category = Category.find_by(@attrs)
    assert { category }
  end

  test 'should update category' do
    patch admin_category_path @category, params: { category: @attrs }

    assert_redirected_to controller: 'web/admin/categories', action: 'index'

    @category.reload
    assert { @attrs[:name] == @category.name }
  end
end
