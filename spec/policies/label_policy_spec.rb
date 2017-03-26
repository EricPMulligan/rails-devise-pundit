require 'rails_helper'

RSpec.describe LabelPolicy do
  subject { LabelPolicy }

  let(:current_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it 'denies access if not an admin' do
      is_expected.not_to permit(current_user, other_user)
    end

    it 'allows access if an admin' do
      is_expected.to permit(admin, other_user)
    end
  end
end
