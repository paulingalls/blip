require "test_helper"

class TextChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @text_chat = text_chats(:one)
  end

  test "should get index" do
    get text_chats_url
    assert_response :success
  end

  test "should get new" do
    get new_text_chat_url
    assert_response :success
  end

  test "should create text_chat" do
    assert_difference('TextChat.count') do
      post text_chats_url, params: { text_chat: { customer_id: @text_chat.customer_id, message_text: @text_chat.message_text, response: @text_chat.response } }
    end

    assert_redirected_to text_chat_url(TextChat.last)
  end

  test "should show text_chat" do
    get text_chat_url(@text_chat)
    assert_response :success
  end

  test "should get edit" do
    get edit_text_chat_url(@text_chat)
    assert_response :success
  end

  test "should update text_chat" do
    patch text_chat_url(@text_chat), params: { text_chat: { customer_id: @text_chat.customer_id, message_text: @text_chat.message_text, response: @text_chat.response } }
    assert_redirected_to text_chat_url(@text_chat)
  end

  test "should destroy text_chat" do
    assert_difference('TextChat.count', -1) do
      delete text_chat_url(@text_chat)
    end

    assert_redirected_to text_chats_url
  end
end
