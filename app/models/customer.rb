class Customer < ApplicationRecord
  has_many :bag_locations
  has_many :events, through: :bag_locations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, uniqueness: true
end
