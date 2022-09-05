# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:user_one)
    sign_in @user
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body, creator: @user.email, title: @post.title, category_id: @post.category.id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    new_post = posts(:two)
    patch post_url(@post), params: { post: { body: new_post.body, creator: new_post.creator, title: new_post.title, category_id: new_post.category.id } }
    assert_redirected_to post_url(@post)

    @post = Post.find(@post.id)
    assert { @post.body == new_post.body }
    assert { @post.creator == new_post.creator }
    assert { @post.title == new_post.title }
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to root_path
  end

  test 'should not redirect unauthrorized user for #show' do
    sign_out users(:user_one)
    get post_url(@post)
    assert_response :success
  end

  test 'should redirect unauthrorized user for #new' do
    sign_out users(:user_one)
    get new_post_url
    assert_response :redirect
  end
end
