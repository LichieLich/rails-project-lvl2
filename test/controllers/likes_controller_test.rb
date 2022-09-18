# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:user_one)
    sign_in @user
    @like = @post.likes.build(post_id: @post.id, user_id: @user.id)
    @like.save
  end

  test 'should create like' do
    post post_likes_url(@post.id), params: { post_like: { post_id: @post.id, user_id: @user.id } }

    created_like = PostLike.last
    assert { created_like.post_id = @post.id }
    assert { created_like.user = @user }
  end

  test 'should destroy like' do
    delete post_like_url(@post.id, @like.id)
    # binding.irb

    refute { @post.likes.find_by(user_id: @user.id) }
  end
end
