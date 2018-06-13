module Api
  module V1
    class BooksController < ApiController
      filter_on :author, type: :string
      filter_on :genre, type: :string
      filter_on :title, type: :string
      filter_on :description, type: :string

      before_action :authenticate_user!, except: [:book_info]

      # Summary: List books with filters ang paginated
      def index
        books = filtrate(Book.all)
        render_paginated(books, each_serializer: BookSerializer)
      end

      # Summary: Show a single book json by id
      def show
        render(json: Book.find(params['id']), serializer: ShowBookSerializer)
      end

      # Summary: Get a book info by isbn
      def book_info
        isbn_info = OpenLibraryService.new.book_info(params['isbn'])
        return record_not_found unless isbn_info
        render(json: isbn_info)
      end
    end
  end
end
