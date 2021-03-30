json.extract! text_chat, :id, :message_text, :customer_id, :response, :created_at, :updated_at
json.url text_chat_url(text_chat, format: :json)
