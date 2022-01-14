# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @bulletin = bulletins(:one)
    @attrs = {
      title: Faker::Lorem.characters(number: 4),
      description: Faker::Lorem.paragraph_by_chars(number: 400),
      category_id: @bulletin.category_id
    }
  end

  test 'guest should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'guest should get show published bulletin' do
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test 'guest cant get show draft bulletin' do
    draft = bulletins(:two)
    get bulletin_path(draft)
    assert_response :redirect
  end

  test 'guest cant get new' do
    get new_bulletin_path
    assert_response :redirect
  end

  test 'guest cant create bulletin' do
    assert_no_difference('Bulletin.count') do
      post bulletins_path, params: { bulletin: @attrs }
    end
  end

  test 'guest cant archive bulletin' do
    bulletin = bulletins(:one)

    patch archive_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.published? }
  end

  test 'guest cant moderate bulletin' do
    bulletin = bulletins(:two)

    patch moderate_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.draft? }
  end

  test 'signed user should get new' do
    sign_in_as_user @user

    get new_bulletin_path
    assert_response :success
  end

  test 'signed user should get show draft bulletin' do
    draft = bulletins(:four)
    sign_in_as_user @user

    get bulletin_path(draft)
    assert_response :success
  end

  test 'signed user should create bulletin' do
    sign_in_as_user @user

    post bulletins_path, params: {
      bulletin: @attrs.merge(image: fixture_file_upload('cat.png', 'image/png'))
    }
    assert_response :redirect

    bulletin = Bulletin.find_by(@attrs)
    assert { bulletin }
  end

  test 'signed user should archive bulletin' do
    bulletin = bulletins(:one)
    sign_in_as_user @user

    patch archive_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.archived? }
  end

  test 'signed user should moderate bulletin' do
    bulletin = bulletins(:two)
    sign_in_as_user users(:two)

    patch moderate_bulletin_path(bulletin)
    assert_response :redirect

    bulletin.reload
    assert { bulletin.under_moderation? }
  end
end
