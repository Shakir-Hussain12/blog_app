require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /user/:id' do
    it 'should show the users index page' do
      get '/users/1'
      expect(response).to be_successful
    end

    it 'should render correct template' do
      get '/users/1'
      expect(response).to render_template(:show)
    end

    it 'should return correct data' do
      get '/users/1'
      expect(response.body).to include('show page for users')
    end
  end
end
