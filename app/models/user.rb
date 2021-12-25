# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, foreign_key: 'creator_id', inverse_of: :creator, dependent: :destroy

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user.email = auth['info']['email']

    user.save
    user
  end
end
