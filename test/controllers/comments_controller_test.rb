# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:first_comment)
    @post = posts(:one)
    @user = users(:user_one)
    sign_in @user
  end

  test 'should get new comment' do
    get new_post_comment_url(@comment.post_id)
    assert_response :success
  end

  test 'should get new reply' do
    get post_comment_url(@comment.post_id, @comment)
    assert_response :success
  end

  test 'should create comment' do
    assert_difference('PostComment.count') do
      post post_comments_url(@comment.post_id), params: { post_comment: { post_id: @comment.post_id, content: @comment.content, user_id: @user.id } }
    end

    assert_redirected_to post_url(Post.find(@comment.post_id))
  end

  test 'should create reply' do
    @reply = post_comments(:two)
    @reply.ancestry = @comment.id
    assert_difference('PostComment.count') do
      post post_comments_url(@comment.post_id, @comment.ancestry), params: { post_comment: { ancestry: @reply.ancestry, post_id: @reply.post_id, content: @reply.content, user_id: @user.id } }
    end

    assert_redirected_to post_url(Post.find(@comment.post_id))
    assert { @comment.has_children? == true }
  end
end
