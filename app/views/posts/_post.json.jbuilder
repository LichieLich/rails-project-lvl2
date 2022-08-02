json.extract! post, :id, :title,, :body,, :creator, :created_at, :updated_at
json.url post_url(post, format: :json)
