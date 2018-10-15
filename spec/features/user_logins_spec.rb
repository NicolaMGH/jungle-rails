require 'rails_helper'

RSpec.feature "User Login", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      first_name: "John",
      last_name: "Smith",
      email: "johnsmith@123.com",
      password: "12345",
      password_confirmation: "12345"
      )
  end

  scenario "User logs in and is redirected to home page" do
    # ACT
    visit '/login'

    fill_in 'email', with: 'johnsmith@123.com'
    fill_in 'password', with: '12345'

    click_on('Sign In')

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text 'Signed in as'

  end

end
