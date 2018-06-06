class UserRentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :book, :user

  def book
    BookSerializer.new(object.book).as_json
  end

  def user
    UserSerializer.new(object.user).as_json
  end
end
