require 'spec_helper'

feature 'user sign out', %Q{
  As an authenticated user
  I want to sign out
  So that I can exit the system
} do

  # ACCEPTANCE CRITERIA
  # Once signed in, I must be able to log out

  scenario 'a signed-in user can log out of his account' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    click_on 'Log Out'

    expect(page).to have_content('Signed out successfully.')
    expect(current_path).to eq(root_path)
  end
end
