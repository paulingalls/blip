json.extract! message, :id, :key, :value, :created_at, :updated_at
json.url message_url(message, format: :json)
