class LabelPolicy < ApplicationPolicy
  def new?
    @user.role == 'admin'
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
