require 'rails_helper'

describe Api::V1::BooksController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the books' do
      let!(:books) { create_list(:book, 3) }

      before do
        get :index
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          books, each_serializer: BookSerializer
        ).to_json

        expect(JSON.parse(response.body)['page']).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When show a book' do
      let!(:book) { create(:book) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responses with a book json' do
        expected = ShowBookSerializer.new(book).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When show a book rented' do
      let!(:book) { create(:book_rented) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responses with a book json' do
        expected = ShowBookSerializer.new(book).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
