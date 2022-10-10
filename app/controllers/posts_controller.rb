# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).arrange
    @new_comment = @post.comments.build
    @users_liked = @post.likes.includes(:user).map { |like| like.user.email[/\w+/] }.join(', ')
    @like_by_user = @post.like_by_user(current_user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
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

  # PATCH/PUT /posts/1
  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post = current_user.posts.find(params[:id])

    @post.destroy
    redirect_to root_path, notice: t('.success')
  end

  private

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
