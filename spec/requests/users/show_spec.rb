require 'rails_helper'

RSpec.describe "Users", type: :system do
    describe 'GET /user/:id' do
        it "should show the users index page" do
            get '/users/1'
            expect(response).to be_successful
        end

        it 'should return correct data' do
            get '/users/1'
            expect(response.body).to have_selector('h1', text: 'This is the show page for users')
        end
    end
end
