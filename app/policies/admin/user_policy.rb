# frozen_string_literal: true

class Admin::UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end
end
