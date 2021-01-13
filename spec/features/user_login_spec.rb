require 'rails_helper'

RSpec.feature "Visitor logins to the website", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      name: 'Johnny Silverhand',
      email: 'samurai@example.com',
      password: 'wakeup',
      password_confirmation: 'wakeup'
    )
  end

  scenario "They see 'Logout' appears after the successful login" do
    # ACT
    visit root_path
    click_on 'Login'
    fill_in 'email', with: 'samurai@example.com'
    fill_in 'password', with: 'wakeup'
    click_on 'Submit'

    # VERIFY
    expect(page).to have_content 'Logout'
    
    # DEBUG
    save_screenshot
  end
end