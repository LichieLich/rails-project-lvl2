# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liked_post = posts(:one)
    @post = posts(:two)
    @user = users(:one)
    @like = post_likes(:one)
    sign_in @user
  end

  test 'should create like' do
    post post_likes_url(@post.id)

    created_like = PostLike.find_by(post_id: @post.id, user_id: @user.id)
    assert { created_like }
  end

  test 'should destroy like' do
    delete post_like_url(@liked_post.id, @like.id)

    assert { @liked_post.likes.find_by(user_id: @user.id).nil? }
  end
end
