require 'rails_helper'

describe Api::V1::BookSuggestionsController do
  describe 'POST #create' do
    context 'When create a book suggestion' do
      let!(:user)   { create(:user) }
      let!(:params) { attributes_for(:book_suggestion).merge(user_id: user.id) }

      subject(:create_request) { post :create, params: params }

      it 'responses with the book suggestion created json' do
        create_request
        expected = BookSuggestionSerializer.new(BookSuggestion.last).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'book suggestions change count by one' do
        expect { create_request }.to change { BookSuggestion.count }.by(1)
      end

      it 'responds with 201 status' do
        create_request
        expect(response).to have_http_status(:created)
      end
    end

    context 'When create a book suggestion without a user' do
      let!(:params) { attributes_for(:book_suggestion) }

      subject(:create_request) { post :create, params: params }

      it 'responses with the book suggestion created json' do
        create_request
        expected = BookSuggestionSerializer.new(BookSuggestion.last).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'book suggestions change count by one' do
        expect { create_request }.to change { BookSuggestion.count }.by(1)
      end

      it 'responds with 201 status' do
        create_request
        expect(response).to have_http_status(:created)
      end
    end

    context 'When create a book suggestion without an author' do
      let!(:params) { attributes_for(:book_suggestion).except(:author) }

      subject(:create_request) { post :create, params: params }

      it 'book suggestions not change count' do
        expect { create_request }.not_to(change { BookSuggestion.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages' do
        create_request
        expect(response.body['error']).to be_present
      end
    end

    context 'When create a book suggestion without title' do
      let!(:params) { attributes_for(:book_suggestion).except(:title) }

      subject(:create_request) { post :create, params: params }

      it 'book suggestions not change count' do
        expect { create_request }.not_to(change { BookSuggestion.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages' do
        create_request
        expect(response.body['error']).to be_present
      end
    end

    context 'When create a book suggestion without link' do
      let!(:params) { attributes_for(:book_suggestion).except(:link) }

      subject(:create_request) { post :create, params: params }

      it 'book suggestions not change count' do
        expect { create_request }.not_to(change { BookSuggestion.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages' do
        create_request
        expect(response.body['error']).to be_present
      end
    end
  end
end
