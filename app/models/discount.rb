class Discount < ApplicationRecord
  validates :rate, presence: true, numericality: {
    greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality: {
    greater_than_or_equal_to: 0}

    belongs_to :item
end