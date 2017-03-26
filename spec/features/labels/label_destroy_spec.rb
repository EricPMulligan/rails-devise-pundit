include Warden::Test::Helpers
Warden.test_mode!

require 'rails_helper'

RSpec.feature 'Label destroy' do
  after(:each) { Warden.test_reset! }

  scenario 'admin deletes an existing label' do
    user = create(:user, :admin)
    login_as(user, scope: :user)
    label = create(:label)
    visit users_path
    click_link "label-#{label.id}"
    expect(page).to have_content I18n.t('labels.deleted')
  end
end
