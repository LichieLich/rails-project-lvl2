# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  def create
    @post_like = find_post.post_likes.build(post_id: params[:post_id], user_id: current_user.id)

    if @post_like.save
      redirect_to post_url(find_post)
    else
      redirect_to post_url(find_post), status: :unprocessable_entity
    end
  end

  def destroy
    @post_like = find_post.post_likes.find_by(user: current_user)
    @post_like.destroy

    respond_to do |format|
      format.html { redirect_to post_url(find_post) }
      format.json { head :no_content }
    end
  end

  private

  def find_post
    Post.find(params[:post_id])
  end
end
