require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Get /index' do
    it 'should return a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'should render correct template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'should return correct data' do
      get '/users'
      expect(response.body).to include('index page for users')
    end
  end
end
