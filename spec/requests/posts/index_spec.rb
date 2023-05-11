require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'GET /users/:id/posts' do
    it 'should show the posts index page' do
      get '/users/11/posts'
      expect(response).to be_successful
    end

    it 'should render correct template' do
      get '/users/11/posts'
      expect(response.body).to include('index page for posts')
    end

    it 'should return correct data' do
      get '/users/11/posts'
      expect(response.body).to have_selector('h1', text: 'This is the index page for posts')
    end
  end
end
