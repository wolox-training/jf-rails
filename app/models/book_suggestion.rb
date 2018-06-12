class BookSuggestion < ApplicationRecord
  validates :author, :title, :link, presence: true

  belongs_to :user
end
