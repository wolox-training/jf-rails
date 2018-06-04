class Book < ApplicationRecord
    validates_presence_of :genre, :author, :image, :title, :publisher, :year

end
