# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module ActionDispatch
  class IntegrationTest
    include AuthConcern

    def sign_in_as_user(user)
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = nil

      params = {
        provider: 'github',
        uid: Faker::Internet.uuid,
        info: {
          email: user.email
        }
      }

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(params)
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

      get '/auth/:provider/callback'
    end

    def sign_in_as_admin(admin)
      post session_path, params: { user: { email: admin.email } }
    end
  end
end

class ActiveStorage::Blob
  def self.fixture(filename:, **attributes)
    blob = new(
      filename: filename,
      key: generate_unique_secure_token
    )
    io = Rails.root.join("test/fixtures/files/#{filename}").open
    blob.unfurl(io)
    blob.assign_attributes(attributes)
    blob.upload_without_unfurling(io)

    blob.attributes.transform_values { |values| values.is_a?(Hash) ? values.to_json : values }.compact.to_json
  end
end
