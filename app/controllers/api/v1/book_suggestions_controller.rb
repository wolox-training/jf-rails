module Api
  module V1
    class BookSuggestionsController < ApiController
      # Summary: Create a book suggestion
      def create
        book_suggestion = BookSuggestion.new(creation_params)
        return invalid_params unless book_suggestion.save
        render(json: book_suggestion, serializer: BookSuggestionSerializer, status: :created)
      end

      private

      # Summary: Check params on creation service
      def creation_params
        params.require(%i[author title link])
        params.permit(:editorial, :price, :author, :title, :link, :publisher, :year, :user_id)
      end
    end
  end
end
