# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:two)
    @bulletin.moderate!
    sign_in_as_admin users(:admin)
  end

  test 'admin should publish bulletin' do
    patch publish_admin_bulletin_path @bulletin

    @bulletin.reload
    assert { @bulletin.published? }
  end

  test 'admin should reject bulletin' do
    patch reject_admin_bulletin_path @bulletin

    @bulletin.reload
    assert { @bulletin.rejected? }
  end

  test 'admin should archive bulletin' do
    patch archive_admin_bulletin_path @bulletin

    @bulletin.reload
    assert { @bulletin.archived? }
  end
end
