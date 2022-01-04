# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def show?
    if user
      true
    else
      record.published?
    end
  end

  def edit?
    author?
  end

  def update?
    author?
  end

  def to_moderate?
    author? && record.draft?
  end

  def archive?
    author? && !record.archived?
  end

  private

  def author?
    record.creator == user
  end
end
