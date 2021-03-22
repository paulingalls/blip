# frozen_string_literal: true

class Customer < ApplicationRecord
  before_save :normalize_phone

  has_many :bag_locations
  has_many :events, through: :bag_locations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, uniqueness: true, phone: true

  def formatted_phone
    parsed_phone = Phonelib.parse(phone_number)
    return phone_number if parsed_phone.invalid?

    formatted =
      if parsed_phone.country_code == '1' # NANP
        parsed_phone.full_national # (415) 555-2671;123
      else
        parsed_phone.full_international # +44 20 7183 8750
      end
    formatted.gsub!(';', ' x') # (415) 555-2671 x123
    formatted
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
