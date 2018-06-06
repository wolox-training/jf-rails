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

    context 'When fetching filtered books by genre' do
      let!(:books) { create_list(:book, 3) }
      let!(:book) { create(:book, genre: 'TestGenre') }

      before do
        get :index, params: { filters: { genre: book.genre } }
      end

      it 'responses with the right book json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          [book], each_serializer: BookSerializer
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
      let!(:book) { create(:book, :rented) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responses with a book json' do
        expected = ShowBookSerializer.new(book).to_json
        rent_expected = RentSerializer.new(book.rents.last).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
        expect(JSON.parse(response.body)['actual_rent']).to eq(JSON.parse(rent_expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context "When request a book that doesn't exists" do
      before do
        get :show, params: { id: rand(1..10) }
      end

      it 'responds with not_found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
