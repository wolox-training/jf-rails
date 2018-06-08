module Api
  module V1
    class BooksController < ApiController
      filter_on :author, type: :string
      filter_on :genre, type: :string
      filter_on :title, type: :string
      filter_on :description, type: :string

      #before_action :authenticate_user!

      # Summary: List books with filters ang paginated
      def index
        books = filtrate(Book.all)
        render_paginated(books, each_serializer: BookSerializer)
      end

      # Summary: Show a single book json by id
      def show
        render(json: Book.find(params['id']), serializer: ShowBookSerializer)
      end
    end
  end
end
