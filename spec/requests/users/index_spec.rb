require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Get /index' do
    it 'should return a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'should render correct path' do
      visit users_path
      expect(current_path).to eq('/users')
    end

    it 'should have the Users content' do
      visit users_path
      expect(page).to have_content('List of all users')
    end

    it 'should have a link' do
      visit users_path
      expect(page).to have_link(href: user_path(1))
    end

    it 'should have another link' do
      visit users_path
      expect(page).to have_link(href: user_path(2))
    end

    it 'should redirect to correct page on link click' do
      visit users_path
      click_link(href: '/users/1')
      expect(page).to have_current_path(user_path(1))
    end

    it 'should redirect to correct user show page' do
      visit users_path
      click_link(href: '/users/2')
      expect(page).to have_current_path(user_path(2))
    end

    it 'should check for specific user names' do
      names = %w[Tom Shakir]
      visit users_path
      names.each do |name|
        expect(page).to have_css('h2', text: name)
      end
    end

    it 'should check for all user names on page' do
      visit users_path
      page.all('h2').each do |h2_element|
        name = h2_element.text
        expect(name).not_to be_empty
        expect(name).to match(/^[A-Za-z\s]+$/)
      end
    end

    it 'should check for all images on page' do
      visit users_path
      page.all('img').each do |image|
        expect(image[:src]).not_to be_empty
        expect(image[:src]).to match(%r{https?://\S+})
      end
    end

    it 'should check for all number of posts' do
      visit users_path
      page.all('p', class: 'item-no').each do |post_tag|
        expect(post_tag.text).not_to be_empty
        expect(post_tag.text).to match(/-?\d+(\.\d+)?/)
      end
    end
  end
end
