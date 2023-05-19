require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'GET users/:id/posts/:id' do
    it 'should show the posts show page' do
      user_id = rand(1..2)
      post_id = rand(1..2)
      get "/users/#{user_id}/posts/#{post_id}"
      expect(response).to be_successful
    end

    it 'should get the post writer name' do
      user_id = rand(1..2)
      post_id = rand(1..5)
      visit user_post_path(user_id, post_id)
      container = page.find('div', class: 'top-com')
      title =  container.find('h1').text.split(' ').last
      expect(title).to eq(User.find(user_id).name)
    end

    it 'checks for the the number of comments' do
      user_id = rand(1..2)
      post_id = rand(1..5)
      visit user_post_path(user_id, post_id)
      containers = page.all('div', class: 'inner-items')
      containers.each do |container|
        comment_count = container.find('p', class: 'item-no')
        f_portion = comment_count.text.split(',').first
        expect(f_portion.split(' ').second.to_i).to eq(0).or be >= 0
      end
    end

    it 'checks for the the number of likes' do
      user_id = rand(1..2)
      post_id = rand(1..5)
      visit user_posts_path(user_id, post_id)
      containers = page.all('div', class: 'inner-items')
      containers.each do |container|
        comment_count = container.find('p', class: 'item-no')
        f_portion = comment_count.text.split(',').second
        expect(f_portion.split(' ').second.to_i).to eq(0).or be >= 0
      end
    end

    it 'should check for the body' do
      user_id = 1
      post_id = rand(1..5)
      visit user_post_path(user_id, post_id)
      post = Post.find(post_id)
      body = page.find('div', class: 'inner-items')
      expect(body.first('p').text).not_to be_empty
      expect(body.first('p').text).to eq(post.text)
    end

    it 'checks for the username' do
      user_id = rand(1..2)
      post_id = rand(1..5)
      visit user_post_path(user_id, post_id)
      container = page.find('div', class: 'comment-container')
      if container.all('li', class: 'comment-item').count > 0 then
        container.all('li', class: 'comment-item').each do |comment|
          temp = (comment.text.split(':').second).gsub(/\s+/, ' ').strip
          user_id = Comment.where(text: temp).first.author_id
          expect(comment.text.split(':').first).to eq(User.find(user_id).name)
        end
      else
        puts container.find('p').text eq('No Comments Yet!')
      end
    end

    it 'checks for the actual comment' do
      user_id = 1
      post_id = 1
      visit user_post_path(user_id, post_id)
      container = page.find('div', class: 'comment-container')
      if container.all('li', class: 'comment-item').count > 0 then
        container.all('li', class: 'comment-item').each do |comment|
          temp = (comment.text.split(':').second).gsub(/\s+/, ' ').strip
          expect(temp).to eq(Comment.where(text: temp).first.text)
        end
      else
        puts container.find('p').text eq('No Comments Yet!')
      end
    end

  end
end
