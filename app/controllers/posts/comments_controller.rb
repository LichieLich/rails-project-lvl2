# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  # before_action :resource_post, only: %i[ create new ]
  before_action :authenticate_user!

  def new_reply
    @new_reply = PostComment.find(params[:id]).children.new
    @new_reply.id = params[:id]

    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @users_liked = @post.likes.includes(:user).map { |like| like.user.email[/\w+/] }.join(', ')

    render 'posts/show'
  end

  def create
    @post = Post.find(params[:post_id])
    params = post_comment_params
    params[:user_id] = current_user.id
    @post_comment = @post.comments.build(params)

    if @post_comment.save
      redirect_to post_url(@post), notice: t('.success')
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_comment_params
    params.require(:post_comment).permit(:content, :id, :ancestry)
  end
end
