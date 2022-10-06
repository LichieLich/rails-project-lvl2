# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  # before_action :resource_post, only: %i[ create new ]
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])

    @post_comment = @post.comments.build(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.ancestry = params[:parent_id] if params[:parent_id]

    if @post_comment.save
      redirect_to post_url(@post), notice: t('.success')
    else
      # render 'posts/show', status: :unprocessable_entity
      redirect_to post_url(@post), notice: t('.failure')
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id, :post_id)
  end
end
