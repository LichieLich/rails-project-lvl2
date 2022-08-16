# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, except: [:index] do
    resources :comments, except: [:index, :show], module: :posts
    get '/comments/:id', to: 'posts/comments#new_reply'
  end

   root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
