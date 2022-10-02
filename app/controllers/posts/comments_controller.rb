# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  # before_action :resource_post, only: %i[ create new ]
  before_action :set_post
  before_action :authenticate_user!

  def new_reply
    @post_comment = PostComment.find(params[:id])
    @post_comment = @post_comment.children.new
    @post_comment.id = params[:id]

    render :_form, locals: { new_comment: @post_comment }
  end

  def create
    params = post_comment_params
    params[:user_id] = current_user.id
    @post_comment = @post.comments.build(params)

    if @post_comment.save
      redirect_to post_url(@post), notice: t('.success')
    else
      render :new, locals: { post: @post }, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_comment_params
    params.require(:post_comment).permit(:content, :id, :ancestry)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
