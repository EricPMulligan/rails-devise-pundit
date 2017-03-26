require 'rails_helper'

RSpec.describe Label do
  it { is_expected.to respond_to :id }
  it { is_expected.to respond_to :created_at }
  it { is_expected.to respond_to :updated_at }
  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :user_id }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :colour }

  it { is_expected.to belong_to :user }

  describe 'uniqueness' do
    let!(:label) { create(:label) }

    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:name, :colour) }
  end
end
