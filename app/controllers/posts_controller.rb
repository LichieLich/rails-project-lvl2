# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
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
    post = Post.find(params[:id])
    @post = post.creator == current_user ? post : nil

    redirect_to root_path, notice: t('.forbidden') unless @post.creator == current_user
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_url(@post), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    post = Post.find(params[:id])
    @post = post.creator == current_user ? post : nil

    if @post.update(post_params)
      redirect_to post_url(@post), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    post = Post.find(params[:id])
    @post = post.creator == current_user ? post : nil

    @post.destroy
    redirect_to root_path, notice: t('.success')
  end

  private

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
