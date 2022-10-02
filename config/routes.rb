# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, only: %i[create show update edit destroy new] do
    resources :comments, only: %i[create], module: :posts
    post '/comments/:id', to: 'posts/comments#new_reply', as: 'comment'

    resources :likes, only: %i[create destroy], module: :posts
  end

  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
