class Book < ApplicationRecord
  validates :genre, :author, :image, :title, :publisher, :year, presence: true

  has_many :rents, dependent: :destroy
end
