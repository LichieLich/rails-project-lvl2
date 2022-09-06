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
    assert_difference('PostLike.count') do
      post post_likes_url(@post.id), params: { post_like: { post_id: @post.id, user_id: @user.id } }
    end
  end

  test 'should destroy like' do
    assert_difference('PostLike.count', -1) do
      delete post_like_url(@post.id, @like.id)
    end
  end
end
