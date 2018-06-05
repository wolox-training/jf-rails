class Rent < ApplicationRecord
  validates :user, :book, :from, :to, presence: true
  validate :from_cannot_be_greater_than_to, if: -> { from.present? && to.present? }

  belongs_to :user
  belongs_to :book

  # Validate from date cannot be greater than to date
  def from_cannot_be_greater_than_to
    errors.add(:from, "can't be greater than to date") if from > to
  end
end
