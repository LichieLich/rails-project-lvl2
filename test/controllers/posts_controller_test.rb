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

    created_post = Post.find_by!(title: @attrs[:title])

    assert { created_post.body == @attrs[:body] }
    assert { created_post.category_id == @attrs[:category_id] }
    assert { created_post.title == @attrs[:title] }
    assert { created_post.creator == @user }

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
    patch post_url(@post), params: { post: @attrs }
    assert_redirected_to post_url(@post)

    @post = Post.find_by!(title: @attrs[:title])

    assert { @post.body == @attrs[:body] }
    assert { @post.title == @attrs[:title] }
    assert { @post.category_id == @attrs[:category_id] }
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
