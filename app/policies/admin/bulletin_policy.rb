# frozen_string_literal: true

class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def publish?
    admin? && record.under_moderation?
  end

  def reject?
    admin? && record.under_moderation?
  end

  def archive?
    admin? && !record.archived?
  end
end
