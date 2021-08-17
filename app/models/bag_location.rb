# frozen_string_literal: true

class BagLocation < ApplicationRecord
  after_create :notify_customer
  belongs_to :event
  belongs_to :customer
  accepts_nested_attributes_for :customer
  validates :location, presence: true

  def notify_customer
    customer.send_text_message(created_message)
  rescue StandardError => e
    raise StandardError, "Problem texting: #{customer.formatted_phone}: #{e.message}"
  end

  def remind_customer
    customer.send_text_message(reminder_message)
  rescue StandardError => e
    raise StandardError, "Problem texting: #{customer.formatted_phone}: #{e.message}"
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
    message.gsub! '%first_name%', customer.first_name
    message.gsub! '%last_name%', customer.last_name
    message.gsub! '%bag_location%', location
    message.gsub! '%claim_number%', claim_number.to_s(10)
    message.gsub! '%event_name%', event.name
    message.gsub! '%event_date%', event.date.to_s(:long)
    message
  end
end
