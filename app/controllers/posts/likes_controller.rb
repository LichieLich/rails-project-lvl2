# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_like = @post.likes.build(post_id: params[:post_id], user_id: current_user.id)

    # Just refresh current page or redirect to to root if refferer is unknown
    redirect_back(fallback_location: root_path) if @post_like.save
  end

  def destroy
    @post_like = @post.likes.find_by(user: current_user)&.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
