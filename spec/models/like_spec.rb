require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:user) { User.new(name: 'Shakir', posts_count: 0) }

  subject(:post) do
    Post.new(author: user, title: 'This is a test for Like model using TDD', comments_count: 0, likes_count: 0)
  end

  subject(:like) { Like.new(author: user, post:) }

  before { like.save }

  it 'should be valid' do
    expect(like).to be_valid
  end

  it 'should update the like counter' do
    expect(post.likes_count).to eq(1)
  end
end
