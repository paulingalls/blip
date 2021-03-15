class BagLocation < ApplicationRecord
  belongs_to :event
  belongs_to :customer
  accepts_nested_attributes_for :customer
  validates :location, presence: true
end
