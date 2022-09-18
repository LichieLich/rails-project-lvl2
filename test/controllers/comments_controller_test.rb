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
    post post_comments_url(@comment.post_id), params: { post_comment: { post_id: @comment.post_id, content: @comment.content, user_id: @user.id } }

    created_comment = @post.comments.last
    assert { created_comment.content == @comment.content }
    assert { created_comment.user == @comment.user }

    assert_redirected_to post_url(Post.find(@comment.post_id))
  end

  test 'should create reply' do
    @reply = post_comments(:two)
    @reply.ancestry = @comment.id
    post post_comments_url(@comment.post_id, @comment.ancestry), params: { post_comment: { ancestry: @reply.ancestry, post_id: @reply.post_id, content: @reply.content, user_id: @user.id } }

    created_reply = @post.comments.last
    assert { created_reply.ancestry == @comment.id.to_s }
    assert { created_reply.content == @reply.content }
    assert { created_reply.user == @user }

    assert_redirected_to post_url(Post.find(@comment.post_id))
    assert { @comment.has_children? == true }
  end
end
