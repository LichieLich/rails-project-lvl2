# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:one)
    @post = posts(:one)
    @user = users(:one)
    @attrs = {
      content: Faker::ChuckNorris.fact
    }
    sign_in @user
  end

  test 'should create comment' do
    post post_comments_url(@post.id), params: { post_comment: @attrs }

    created_comment = @post.comments.find_by(@attrs)
    assert { created_comment.user == @user }

    assert_redirected_to post_url(@post)
  end

  test 'should create reply' do
    @attrs[:parent_id] = @comment.id
    post post_comments_url(@post.id), params: { post_comment: @attrs }

    created_reply = @post.comments.find_by(content: @attrs[:content], user_id: @user.id)
    assert { created_reply }

    assert_redirected_to post_url(@post)
    assert { @comment.has_children? == true }
  end
end
