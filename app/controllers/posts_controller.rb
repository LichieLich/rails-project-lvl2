# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  # GET /posts/1 or /posts/1.json
  def show
    # @post = Post.find(params[:id])
    @comments = @post.comments
    @new_comment = @post.comments.build
    @users_liked = @post.likes.includes(:user).map { |like| like.user.email[/\w+/] }.join(', ')
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    redirect_to root_path, notice: t('.forbidden') unless @post.creator == current_user
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.creator_id = current_user.id

    if @post.save
      redirect_to post_url(@post), notice: t('.success')
    else
      render :new, locals: { post: @post }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.creator == current_user
      if @post.update(post_params)
        redirect_to post_url(@post), notice: t('.success')
      else
        render :edit, locals: { post: @post }, status: :unprocessable_entity
      end
    else
      redirect_to root_path, notice: t('.forbidden')
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.creator == current_user
      @post.destroy
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, notice: t('.forbidden')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    # post = Post.find(params[:id])
    # @post = post.creator == current_user ? post : nil
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
