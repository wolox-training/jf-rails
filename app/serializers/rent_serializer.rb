class RentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :book_id, :user_id
end
