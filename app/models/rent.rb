class Rent < ApplicationRecord
  validate :from_cannot_be_greater_than_to

  belongs_to :user
  belongs_to :book

  # Validate from date cannot be greater than to date
  def from_cannot_be_greater_than_to
    errors.add(:from, "can't be greater than to date") if from > to
  end
end
