class Event < ApplicationRecord
  has_many :bag_locations, dependent: :destroy
  has_many :customers, through: :bag_locations

  validates :name, presence: true
  validates :date, presence: true
end
