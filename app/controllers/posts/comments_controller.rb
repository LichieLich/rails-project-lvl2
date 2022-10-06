# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  before_action :authenticate_user!

  def create
    resource_post

    @post_comment = @resource_post.comments.build(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.ancestry = params[:parent_id] if params[:parent_id]

    if @post_comment.save
      redirect_to post_url(@resource_post), notice: t('.success')
    else
      redirect_to post_url(@resource_post), notice: t('.failure')
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id, :post_id)
  end
end
