require 'rails_helper'

RSpec.feature 'User', type: :feature do
  feature "Signing in" do
    background do
      User.create!(email: 'user@example.com', author_name: 'Testautor', password: 'caplin')
    end
  
    scenario 'Signing in with correct credentials' do
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'caplin'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end
  end
end