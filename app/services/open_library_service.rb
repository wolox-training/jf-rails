class OpenLibraryService < Wor::Requests::Base
  # Get books info
  def book_info(isbn)
    response = get(
      attempting_to: "get book info with #{isbn}",
      path: "/books?jscmd=data&format=json&bibkeys=#{isbn}"
    )
    return nil unless response.key?(isbn)
    build_book_info(response, isbn)
  rescue Wor::Requests::RequestError => e
    Rails.logger e.message
  end

  protected

  def base_url
    'https://openlibrary.org/api'
  end

  def build_book_info(api_response, isbn)
    book_info = api_response[isbn].slice('title', 'subtitle', 'number_of_pages')
    book_info['authors'] = api_response[isbn]['authors'].map { |a| a['name'] }
    Hash[isbn => book_info]
  end
end
