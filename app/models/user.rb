# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :email, presence: true

  def self.find_or_create_by_auth(auth)
    find_or_create_by!(email: auth&.info&.email)
  end
end
