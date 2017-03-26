include Warden::Test::Helpers
Warden.test_mode!

require 'rails_helper'

RSpec.feature 'Label new', devise: true do
  after(:each) { Warden.test_reset! }

  scenario 'admin adds a new label to a user' do
    user = create(:user, :admin)
    login_as(user, scope: :user)
    other_user = create(:user)
    visit new_user_label_path(other_user)

    within '#new_label' do
      fill_in 'label_name',   with: Faker::Name.name
      select 'White', from: 'label_colour'
      click_button 'Create Label'
    end

    expect(page).to have_content I18n.t('labels.created')
  end

  scenario 'admin adds a new label that has the same name but not the same colour as another label' do
    user = create(:user, :admin)
    login_as(user, scope: :user)
    other_user = create(:user)
    label = create(:label, colour: 'white', user: other_user)
    visit new_user_label_path(other_user)

    within '#new_label' do
      fill_in 'label_name',   with: label.name
      select 'Purple', from: 'label_colour'
      click_button 'Create Label'
    end

    expect(page).to have_content I18n.t('labels.created')
  end

  scenario 'admin adds a new label that has the same name and colour as another label' do
    user = create(:user, :admin)
    login_as(user, scope: :user)
    other_user = create(:user)
    label = create(:label, colour: 'purple', user: other_user)
    visit new_user_label_path(other_user)

    within '#new_label' do
      fill_in 'label_name',   with: label.name
      select 'Purple', from: 'label_colour'
      click_button 'Create Label'
    end

    expect(page).to have_content I18n.t('labels.errors.unique')
  end
end
