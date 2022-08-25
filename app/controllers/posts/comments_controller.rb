# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  # before_action :resource_post, only: %i[ create new ]
  before_action :set_post_comment, only: %i[new_reply]

  def index
    @post_comments = PostComment.all
  end

  def new
    @post_comment = find_post.post_comments.build
  end

  def new_reply
    set_post_comment
    @post_comment = @post_comment.children.new
    @post_comment.post_id = params[:post_id]
  end

  def create
    if post_comment_params['ancestry']
      ancestor_comment = PostComment.find(post_comment_params['ancestry'])
      @post_comment = ancestor_comment.children.create(post_comment_params)
      @post_comment.post_id = ancestor_comment.post_id
    else
      @post_comment = find_post.post_comments.build(post_comment_params)
    end

    respond_to do |format|
      if @post_comment.save
        format.html { redirect_to post_url(find_post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: find_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_comment.errors, status: :unprocessable_entity }
      end
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
