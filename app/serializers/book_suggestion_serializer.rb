class BookSuggestionSerializer < ActiveModel::Serializer
  attributes :id, :editorial, :price, :author, :title, :link, :publisher, :year, :user
end
