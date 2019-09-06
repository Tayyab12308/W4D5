require 'rails_helper'
require 'spec_helper'

feature 'the sign up process', type: :feature do

  scenario 'has a new user page' do
    visit new_user_url
    save_and_open_page
    expect(page).to have_content('Sign up')
  end
  
  scenario 'signing up a user' do
    visit new_user_url
    expect(page).to have_content('Sign up')
    fill_in('username', with: 'user1')
    fill_in('password', with: 'password')
    save_and_open_page
    click_button('Submit')
  end

end