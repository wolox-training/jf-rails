class BooksController < ApplicationController
  include Wor::Paginate
  include Brita

  filter_on :author, type: :string
  filter_on :genre, type: :string
  filter_on :title, type: :string
  filter_on :description, type: :string

  # Summary: List books with filters ang paginated
  def index
    books = filtrate(Book.all)
    render_paginated(books, each_serializer: BookSerializer)
  end

  # Summary: Show a single book json by id
  def show
    return render(plain: 'Not Found', status: :not_found) unless Book.exists?(params['id'])
    render(json: Book.find(params['id']), serializer: ShowBookSerializer)
  end
end
