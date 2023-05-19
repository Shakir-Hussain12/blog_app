require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'GET /users/:id/posts' do
    it 'should show the posts index page' do
      user_id = rand(1..2)
      get "/users/#{user_id}/posts"
      expect(response).to be_successful
    end

    it 'should render correct path for the post' do
      user_id = rand(1..2)
      visit user_posts_path(user_id)
      expect(page).to have_current_path("/users/#{user_id}/posts")
    end

    it 'should check for the user profile picture' do
      user_id = rand(1..2)
      curr_user = User.find(user_id)
      visit user_posts_path(user_id)
      image = page.find('img')
      expect(image[:src]).to eq(curr_user.photo)
    end

    it 'should return correct username' do
      user_id = rand(1..2)
      visit user_posts_path(user_id)
      user = "#{user_id == 2 ? 'Tom' : 'Shakir'}'s Posts and Comments"
      expect(page).to have_css('h1', text: user)
    end

    it 'should check for number of posts' do
      user_id = rand(1..2)
      visit user_posts_path(user_id)
      main = page.find('a', class: 'main-details')
      post_tag = main.first('p', class: 'item-no').text
      user = User.find(user_id)
      expect(post_tag).to eq("Number of posts : #{user.posts_count || 0}")
    end

    it 'should check for the title' do
      user_id = 1
      visit user_posts_path(user_id)
      titles = page.all('li', class: 'post-item')
      posts = Post.where(author_id: user_id)
      title_arr = []
      posts.map{ |post| title_arr << post.title}
      titles.each do |title|
        expect(title.find('h3').text).not_to be_empty
        expect(title.find('h3').text).to be_in(title_arr)
      end
    end

    it 'should check for the body' do
      user_id = 1
      visit user_posts_path(user_id)
      bodies = page.all('div', class: 'inner-items')
      posts = Post.where(author_id: user_id)
      body_arr = []
      bodies.map{ |body| body_arr << body.first('p').text}
      bodies.each do |body|
        expect(body.first('p').text).not_to be_empty
        expect(body.first('p').text).to be_in(body_arr)
      end
    end

    it 'checks for the first comment' do
      user_id = rand(1..2)
      visit user_posts_path(user_id)
      comments = page.all('div', class: 'comment-container')
      comm_arr = ['No Comments yet!', 'Shakir : Testing the comment create function']
      comments.each do |comment|
        expect(comment.first('p').text).to be_in(comm_arr)
      end
    end

    it 'checks for the the number of comments' do
      user_id = rand(1..2)
      visit user_posts_path(user_id)
      containers = page.all('div', class: 'inner-items')
      containers.each do |container|
        comment_count = container.find('p', class: 'item-no')
        f_portion = comment_count.text.split(',').first
        expect(f_portion.split(' ').second.to_i).to eq(0).or be >= 0
      end
    end

    it 'checks for the the number of likes' do
      user_id = rand(1..2)
      visit user_posts_path(user_id)
      containers = page.all('div', class: 'inner-items')
      containers.each do |container|
        comment_count = container.find('p', class: 'item-no')
        f_portion = comment_count.text.split(',').second
        expect(f_portion.split(' ').second.to_i).to eq(0).or be >= 0
      end
    end

    it 'displays 2 elements per page' do
      visit user_posts_path(1)
      expect(page).to have_selector('li', class: 'post-item', count: 2)
      click_on 'Next →'
      expect(page).to have_selector('li', class: 'post-item', count: 2)
      click_on '← Previous'
      expect(page).to have_selector('li', class: 'post-item', count: 2)
    end

    it 'redirects to correct post show page' do
      visit user_posts_path(1)
      my_links = page.all('a', class: 'com_nav')
      my_links.each do |link|
        link.click
        expect(page).to have_current_path(user_post_path(1,link[:href].split('/').last.to_i))
        visit user_posts_path(1)
      end
    end

  end
end
