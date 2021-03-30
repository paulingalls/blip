require "application_system_test_case"

class TextChatsTest < ApplicationSystemTestCase
  setup do
    @text_chat = text_chats(:one)
  end

  test "visiting the index" do
    visit text_chats_url
    assert_selector "h1", text: "Text Chats"
  end

  test "creating a Text chat" do
    visit text_chats_url
    click_on "New Text Chat"

    fill_in "Customer", with: @text_chat.customer_id
    fill_in "Message text", with: @text_chat.message_text
    check "Response" if @text_chat.response
    click_on "Create Text chat"

    assert_text "Text chat was successfully created"
    click_on "Back"
  end

  test "updating a Text chat" do
    visit text_chats_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @text_chat.customer_id
    fill_in "Message text", with: @text_chat.message_text
    check "Response" if @text_chat.response
    click_on "Update Text chat"

    assert_text "Text chat was successfully updated"
    click_on "Back"
  end

  test "destroying a Text chat" do
    visit text_chats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Text chat was successfully destroyed"
  end
end
