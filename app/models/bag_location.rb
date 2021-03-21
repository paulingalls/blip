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
      body: 'Bag Location Created'
    )
  end
end
