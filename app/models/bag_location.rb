# frozen_string_literal: true

class BagLocation < ApplicationRecord
  after_create :notify_customer
  belongs_to :event
  belongs_to :customer
  accepts_nested_attributes_for :customer
  validates :location, presence: true

  def notify_customer
    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV.fetch('TWILIO_PHONE_NUMBER'),
      to: customer.phone_number,
      body: created_message
    )
  end

  def remind_customer
    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV.fetch('TWILIO_PHONE_NUMBER'),
      to: customer.phone_number,
      body: reminder_message
    )
  end

  private

  def created_message
    message = Message.find_by_key(Message::BAG_LOCATION_CREATED_KEY).value
    filter_message(message)
  end

  def reminder_message
    message = Message.find_by_key(Message::REMINDER_KEY).value
    filter_message(message)
  end

  def filter_message(message)
    message.sub! '%first_name%', customer.first_name
    message.sub! '%last_name%', customer.last_name
    message.sub! '%bag_location%', location
    message.sub! '%claim_number%', claim_number.to_s(10)
    message
  end
end
