require 'rails_helper'

RSpec.feature 'Article', type: :feature do
  setup do
    Capybara.current_driver = :selenium_chrome
  end

  describe 'Article' do
    let!(:user) { User.create!(email: 'user@example.com', author_name: 'Testautor', password: 'caplin') }
    let!(:article) { Article.create!(headline: 'Headline', body: 'Test Body Text and some stuff', user_id: user.id) }

    before(:each) do
      visit '/users/sign_in'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'caplin'
      click_button 'Log in'
    end

    describe '#CREATE' do
      it 'Creates a new Article' do
        visit "users/#{user.id}/articles/new"
        fill_in 'article_headline', with: 'Test Headline'
        fill_in 'article_body', with: 'Some boring Text'
        click_button 'commit'
        expect(page).to have_content 'Article was successfully created'
      end

      it 'Shows a Blank error' do
        visit "users/#{user.id}/articles/new"
        fill_in 'article_body', with: 'Some boring Text'
        click_button 'commit'
        expect(page).to have_content "Headline can't be blank"
      end
    end

    describe '#UPDATE' do
      it 'Updates a selected Article' do
        visit "users/#{user.id}/articles/#{article.id}/edit"
        fill_in 'article_headline', with: 'Updated Headline'
        fill_in 'article_body', with: 'Some updated boring Text'
        click_button 'commit'
        expect(page).to have_content 'Article was successfully updated'
      end

      it 'Shows a Blank error' do
        visit "users/#{user.id}/articles/#{article.id}/edit"
        fill_in 'article_headline', with: ''
        fill_in 'article_body', with: 'Some boring Text'
        click_button 'commit'
        expect(page).to have_content "Headline can't be blank"
      end
    end

    describe '#DESTROY' do
      it 'Destroys selected Article', js: true do
        visit root_path
        accept_alert do
          within_table '' do
            click_link 'Destroy'
          end
        end
        expect(page).to have_content 'Article was successfully destroyed.'
      end
    end
  end
end
