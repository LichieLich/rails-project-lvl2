# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:one)
    @reply = post_comments(:two)
    @post = posts(:one)
    @user = users(:one)
    @attrs = {
      content: Faker::ChuckNorris.fact
    }
    sign_in @user
  end

  test 'should create comment' do
    post post_comments_url(@comment.post_id), params: { post_comment: @attrs }

    created_comment = @post.comments.find_by!(content: @attrs[:content])

    assert { created_comment.content == @attrs[:content] }
    assert { created_comment.user == @user }

    assert_redirected_to post_url(@post)
  end

  test 'should create reply' do
    post post_comments_url(@comment.post_id), params: { post_comment: { parent_id: @comment.id, post_id: @post.id, content: @attrs[:content] } }

    created_reply = @post.comments.find_by!(content: @attrs[:content])

    assert { created_reply.ancestry == @comment.id.to_s }
    assert { created_reply.content == @attrs[:content] }
    assert { created_reply.user == @user }

    assert_redirected_to post_url(@post)
    assert { @comment.has_children? == true }
  end
end
