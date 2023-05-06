require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(name: 'Shakir', posts_count: 0) }

  let!(:post) do
    Post.create(author: user, title: 'This is a test for post using TDD', comments_count: 0, likes_count: 0)
  end
  let!(:post1) do
    Post.create(author: user, title: 'This is a test for post1 using TDD', comments_count: 0, likes_count: 0)
  end
  let!(:post2) do
    Post.create(author: user, title: 'This is a test for post2 using TDD', comments_count: 0, likes_count: 0)
  end
  let!(:post3) do
    Post.create(author: user, title: 'This is a test for post3 using TDD', comments_count: 0, likes_count: 0)
  end

  before { user.save }

  it 'name should be present' do
    user.name = '     '
    expect(user).to_not be_valid
  end

  it 'posts_count should be present' do
    user.posts_count = nil
    expect(user).to_not be_valid
  end

  it 'posts_count should be greater than or equal to 0' do
    user.posts_count = -1
    expect(user).to_not be_valid
  end

  it 'posts_count should be an integer' do
    user.posts_count = 1.5
    expect(user).to_not be_valid
  end

  it 'user be valid' do
    expect(user).to be_valid
  end

  it 'should return 4 most recent posts' do
    expect(user.recent_posts(4)).to eq([post3, post2, post1, post])
  end

  it 'should return 2 most recent posts' do
    expect(user.recent_posts(2)).to eq([post3, post2])
  end

  it 'update_post_counter_cache' do
    expect(user.posts_count).to eq(4)
  end
end
