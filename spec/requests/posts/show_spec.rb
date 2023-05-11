require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET users/:id/posts/:id' do
    it 'should show the posts show page' do
      get '/users/123/posts/456'
      expect(response).to be_successful
    end

    it 'should render correct template' do
      get '/users/123/posts/456'
      expect(response.body).to render_template(:show)
    end

    it 'should return correct data' do
      get '/users/123/posts/456'
      expect(response.body).to include('show page for posts')
    end
  end
end
