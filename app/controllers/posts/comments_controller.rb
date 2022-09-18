# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  # before_action :resource_post, only: %i[ create new ]
  before_action :set_post_comment, only: %i[new_reply]
  before_action :authenticate_user!

  def new
    @post_comment = find_post.comments.build
  end

  def new_reply
    @post_comment = @post_comment.children.new
    @post_comment.post_id = params[:post_id]

    render 'new'
  end

  def create
    params = post_comment_params
    params[:user_id] = current_user.id
    @post_comment = find_post.comments.build(params)

    if @post_comment.save
      redirect_to post_url(find_post), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_comment_params
    params.require(:post_comment).permit(:content, :post_id, :ancestry)
  end

  def find_post
    Post.find(params[:post_id])
  end
end
