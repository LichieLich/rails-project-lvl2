# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  before_action :authenticate_user!

  def create
    resource_post
    @post_like = @resource_post.likes.create(user_id: current_user.id)

    # Just refresh current page or redirect to to root if refferer is unknown
    redirect_back(fallback_location: root_path)
  end

  def destroy
    resource_post
    @post_like = @resource_post.likes.find_by(user: current_user)&.destroy

    redirect_back(fallback_location: root_path)
  end
end
