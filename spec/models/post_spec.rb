require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:user) { User.new(name: 'Shakir', posts_count: 0) }

  let!(:post) do
    Post.create(author: user, title: 'This is a test for post model using TDD', comments_count: 0, likes_count: 0)
  end

  let!(:comment) do
    Comment.create(author: user, post:, text: 'This is a test for comment using TDD')
  end

  let!(:comment1) do
    Comment.create(author: user, post:, text: 'This is a test for comment1 using TDD')
  end

  let!(:comment2) do
    Comment.create(author: user, post:, text: 'This is a test for comment2 using TDD')
  end

  let!(:comment3) do
    Comment.create(author: user, post:, text: 'This is a test for comment3 using TDD')
  end

  before { post.save }

  it 'title should not be empty' do
    post.title = ''
    expect(post).to_not be_valid
  end

  it 'title should be less than or equal to 250 characters' do
    post.title = 'a' * 251
    expect(post).to_not be_valid
  end

  it 'comments_count should be present' do
    post.comments_count = nil
    expect(post).to_not be_valid
  end

  it 'comments_count should be greater than or equal to 0' do
    post.comments_count = -1
    expect(post).to_not be_valid
  end

  it 'comments_count should be an integer' do
    post.comments_count = 1.5
    expect(post).to_not be_valid
  end

  it 'likes_count should be present' do
    post.likes_count = nil
    expect(post).to_not be_valid
  end

  it 'likes_count should be greater than or equal to 0' do
    post.likes_count = -1
    expect(post).to_not be_valid
  end

  it 'likes_count should be an integer' do
    post.likes_count = 1.5
    expect(post).to_not be_valid
  end

  it 'post should be valid' do
    expect(post).to be_valid
  end

  it 'should return 4 most recent comments' do
    expect(post.recent_comments(4)).to eq([comment3, comment2, comment1, comment])
  end

  it 'should return 2 most recent comments' do
    expect(post.recent_comments(2)).to eq([comment3, comment2])
  end

  it 'update_comment_counter_cache' do
    expect(post.comments_count).to eq(4)
  end
end
