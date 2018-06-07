class RentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :book, :user

  belongs_to :user
  belongs_to :book
end
