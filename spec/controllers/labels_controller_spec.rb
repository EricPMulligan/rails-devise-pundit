require 'rails_helper'

RSpec.describe LabelsController do
  describe 'GET #new' do
    context 'the user is signed in as an admin' do
      let!(:user) { create(:user, :admin) }
      let!(:other_user) { create(:user) }

      before do
        sign_in user
        get :new, params: { user_id: other_user.id }
      end

      it { is_expected.to respond_with :ok }
    end
  end

  describe 'POST #create' do
    context 'the user is signed in as an admin and enters the required information' do
      let!(:user) { create(:user, :admin) }
      let!(:other_user) { create(:user) }

      before(:each) do
        sign_in user
        post :create, params: {
          user_id: other_user.id,
          label: {
            name:   Faker::Name.name,
            colour: Faker::Color.color_name
          }
        }
      end

      it { is_expected.to respond_with :redirect }
      it { is_expected.to redirect_to :users }
      it { is_expected.to set_flash[:notice].to(I18n.t('labels.created')) }
    end

    context 'the user is signed in as an admin and enters the same name and colour as another label associated the same user' do
      let!(:user) { create(:user, :admin) }
      let!(:label) { create(:label) }

      before(:each) do
        sign_in user
        post :create, params: {
          user_id: label.user.id,
          label: {
            name:   label.name,
            colour: label.colour
          }
        }
      end

      it { is_expected.to respond_with :ok }
      it { is_expected.to set_flash.now[:alert].to(I18n.t('labels.errors.unique')) }
    end
  end

  describe 'DELETE #destroy' do
    context 'the user is an admin and the label exists' do
      let!(:user) { create(:user, :admin) }
      let!(:label) { create(:label) }

      before(:each) do
        sign_in(user)
        delete :destroy, params: { user_id: label.user.id, id: label.id }
      end

      it { is_expected.to respond_with :redirect }
      it { is_expected.to redirect_to users_path }
      it { is_expected.to set_flash[:notice].to(I18n.t('labels.deleted')) }
    end
  end
end
