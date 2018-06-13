module OpenLibraryStubs
  def get_book_info # rubocop:disable Naming/AccessorMethodName
    stub_request(:any, %r{.*/api/books\S*$})
      .to_return(
        body: File.read(file_fixture('books/isbn_book_info.json')),
        status: 200
      )
  end
end
