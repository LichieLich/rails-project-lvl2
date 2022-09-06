# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_like = find_post.likes.build(post_id: params[:post_id], user_id: current_user.id)

    if @post_like.save
      # Just refresh current page or redirect to to root if refferer is unknown
      redirect_back(fallback_location: root_path)
    else
      redirect_to post_url(find_post), status: :unprocessable_entity
    end
  end

  def destroy
    @post_like = find_post.likes.find_by(user: current_user)
    @post_like.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  private

  def find_post
    Post.find(params[:post_id])
  end
end
