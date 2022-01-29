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
      admin? || author? || record.published?
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

  def moderate?
    author? && record.draft?
  end

  def archive?
    author? && !record.archived?
  end

  private

  def author?
    record.user == user
  end
end
