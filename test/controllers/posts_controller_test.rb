# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
    @attrs = {
      title: Faker::BossaNova.artist,
      category_id: categories(:one).id,
      body: Faker::ChuckNorris.fact
    }
    sign_in @user
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    post posts_url, params: { post: @attrs }

    created_post = @user.posts.find_by(@attrs)
    assert { created_post }

    assert_redirected_to post_url(created_post)
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
    patch post_url(@post), params: { post: @attrs }
    assert_redirected_to post_url(@post)

    updated_post = @user.posts.find_by(@attrs)

    assert { @post.id == updated_post.id }
  end

  test 'should destroy post' do
    delete post_url(@post)

    assert { Post.find_by(id: @post.id).nil? }

    assert_redirected_to root_path
  end

  test 'should not redirect unauthrorized user for #show' do
    sign_out users(:one)
    get post_url(@post)
    assert_response :success
  end

  test 'should redirect unauthrorized user for #new' do
    sign_out users(:one)
    get new_post_url
    assert_response :redirect
  end
end
