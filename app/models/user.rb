# frozen_string_literal: true

class User < ApplicationRecord
  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user.email = auth['info']['email']

    user.save
    user
  end
end
