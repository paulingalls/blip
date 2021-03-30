# frozen_string_literal: true

class TextChatsController < ApplicationController
  load_and_authorize_resource
  before_action :load_customer
  before_action :set_text_chat, only: %i[show edit update destroy]

  # GET /text_chats or /text_chats.json
  def index
    @text_chats = @customer.text_chats
  end

  # GET /text_chats/1 or /text_chats/1.json
  def show; end

  # GET /text_chats/new
  def new
    @text_chat = @customer.text_chats.build
  end

  # GET /text_chats/1/edit
  def edit; end

  # POST /text_chats or /text_chats.json
  def create
    @text_chat = @customer.text_chats.build(text_chat_params)
    success = @text_chat.save
    @customer.send_text_message(@text_chat.message_text) if success
    respond_to do |format|
      if success
        format.html { redirect_to @customer, notice: 'Message Sent.' }
        format.json { render :show, status: :created, location: @text_chat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @text_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /text_chats/1 or /text_chats/1.json
  def update
    respond_to do |format|
      if @text_chat.update(text_chat_params)
        format.html { redirect_to @text_chat, notice: 'Text message was successfully updated.' }
        format.json { render :show, status: :ok, location: @text_chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @text_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_chats/1 or /text_chats/1.json
  def destroy
    @text_chat.destroy
    respond_to do |format|
      format.html { redirect_to text_chats_url, notice: 'Text chat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_text_chat
    @text_chat = TextChat.find(params[:id])
  end

  def load_customer
    @customer = Customer.find(params[:customer_id])
  end

  # Only allow a list of trusted parameters through.
  def text_chat_params
    params.require(:text_chat).permit(:message_text, :customer_id, :response)
  end
end
