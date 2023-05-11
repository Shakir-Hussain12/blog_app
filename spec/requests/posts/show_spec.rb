require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'GET users/:id/posts/:id' do
    it 'should show the posts show page' do
      get '/users/123/posts/456'
      expect(response).to be_successful
    end

    it 'should render correct template' do
      visit user_post_path(1, 2)
      expect(page).to have_current_path('/users/1/posts/2')
    end

    it 'should return correct data' do
      get '/users/123/posts/456'
      expect(response.body).to match(%r{<h1>\s*This is the show page for posts\s*</h1>})
    end
  end
end
