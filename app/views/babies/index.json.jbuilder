json.array!(@babies) do |baby|
  json.extract! baby, :id, :age, :user_id
  json.url baby_url(baby, format: :json)
end
