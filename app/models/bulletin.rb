# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :creator, class_name: 'User'
  belongs_to :category

  validates :title, presence: true
  validates :image, presence: true
  validates :body, presence: true, length: { minimum: 50 }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :approve do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end
end
