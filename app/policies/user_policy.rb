class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.kept
      else
        scope.kept.where(id: user.id)
      end
    end
  end

  def index?
    true
  end

  def show?
    admin_or_same_user?
  end

  def update?
    admin_or_same_user?
  end

  def destroy?
    admin_or_same_user?
  end

  private

    def same_user?
      record == user
    end

    def admin_or_same_user?
      user.admin? || same_user?
    end
end
