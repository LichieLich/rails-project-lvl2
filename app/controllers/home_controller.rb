# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.includes(:creator, :category, :likes).order(created_at: :desc)
  end
end
