require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:user) { User.new(name: 'Shakir', posts_count: 0) }

  subject(:post) do
    Post.new(author: user, title: 'This is a test for comment model using TDD', comments_count: 0, likes_count: 0)
  end

  subject(:comment) { Comment.new(author: user, post:, text: 'This is a test for comment model using TDD') }

  before { comment.save }

  it 'should be valid' do
    expect(comment).to be_valid
  end

  it 'should update the comments counter' do
    expect(post.comments_count).to eq(1)
  end
end
