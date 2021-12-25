# frozen_string_literal: true

class Bulletin < ApplicationRecord
  has_one_attached :image

  belongs_to :creator, class_name: 'User'
  belongs_to :category

  validates :title, presence: true
  validates :image, presence: true
  validates :body, presence: true, length: { minimum: 50 }
end
