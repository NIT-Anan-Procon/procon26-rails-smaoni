json.array!(@users) do |user|
  json.extract! user, :id, :account, :password, :hash, :name
  json.url user_url(user, format: :json)
end
