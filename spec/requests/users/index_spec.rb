require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Get /index' do
    it 'should return a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'should render correct template' do
      visit users_path
      expect(page).to have_current_path('/users')
    end

    it 'should return correct data' do
      get '/users'
      expect(response.body).to have_selector('h1', text: 'This is the index page for users')
    end
  end
end
