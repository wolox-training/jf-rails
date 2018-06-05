class ShowBookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :genre, :publisher, :year, :image_url, :actual_rent

  def image_url
    object.image
  end

  def actual_rent
    RentSerializer.new(object.rents.last).as_json
  end
end
