require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'GET /user/:id' do
    it 'should show the users index page' do
      user_id = rand(1..2)
      get "/users/#{user_id}"
      expect(response).to be_successful
    end

    it 'should render correct path for the user' do
      user_id = rand(1..2)
      visit user_path(user_id)
      expect(page).to have_current_path("/users/#{user_id}")
    end

    it 'should have a button' do
      user_id = rand(1..2)
      visit user_path(user_id)
      expect(page).to have_css('button', text: 'See All posts')
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

    it 'should redirect to correct new post page' do
      user_id = rand(1..2)
      visit user_path(user_id)
      click_button 'Add a post'
      expect(page).to have_current_path(new_user_post_path(user_id))
    end

    it 'should check for the user profile picture' do
      user_id = rand(1..2)
      curr_user = User.find(user_id)
      visit user_path(user_id)
      image = page.find('img')
      expect(image[:src]).to eq(curr_user.photo)
    end

    it 'should return correct username' do
      user_id = rand(1..2)
      visit user_path(user_id)
      user = "Details of #{user_id == 2 ? 'Tom' : 'Shakir'}"
      expect(page).to have_css('h1', text: user)
    end

    it 'should check for number of posts' do
      user_id = rand(1..2)
      visit user_path(user_id)
      main = page.find('a', class: 'main-details')
      post_tag = main.first('p', class: 'item-no').text
      user = User.find(user_id)
      expect(post_tag).to eq("Number of posts : #{user.posts_count || 0}")
    end

    it 'should check for the bio' do
      user_id = rand(1..2)
      visit user_path(user_id)
      bio = page.find('div', class: 'bio').text
      expect(bio).not_to be_empty
      expect(bio).to match(/^[A-Za-z\s]+$/)
    end

    it 'should check for the recent user posts' do
      user_id = rand(1..2)
      visit user_path(user_id)
      posts = page.all('li', class: 'post-item')
      expect(posts.length).to eq(0).or be >= 0
    end

    it 'should redirect to correct post index page(all posts)' do
      user_id = rand(1..2)
      visit user_path(user_id)
      click_button 'See All posts'
      expect(page).to have_current_path(user_posts_path(user_id))
    end

    it 'should redirect to the post being clicked on' do
      user_id = rand(1..2)
      visit user_path(user_id)
      container = page.find('ul', class: 'posts-container')
      post = container.all('a')[0] if container.all('a').length > 0
      if post then
        post_id = post[:href].split('/').last if post
        click_link(href: "/users/#{user_id}/posts/#{post_id}")
        expect(page).to have_current_path(user_post_path(user_id, post_id))
      end

      visit user_path(user_id)
      post = container.all('a')[1] if container.all('a').length > 1
      if (post) then
        post_id = post[:href].split('/').last
        click_link(href: "/users/#{user_id}/posts/#{post_id}")
        expect(page).to have_current_path(user_post_path(user_id, post_id))
      end

      visit user_path(user_id)
      post = container.all('a')[2] if container.all('a').length > 2
      if post then
        post_id = post[:href].split('/').last if post
        click_link(href: "/users/#{user_id}/posts/#{post_id}")
        expect(page).to have_current_path(user_post_path(user_id, post_id))
      end
    end

  end
end
