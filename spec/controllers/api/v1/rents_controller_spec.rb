require 'rails_helper'

describe Api::V1::RentsController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the rents by user' do
      let!(:rents) { create_list(:rent, 3, user: user) }

      before do
        get :index, params: { user_id: user.id }
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: UserRentSerializer
        ).to_json

        expect(JSON.parse(response.body)['page']).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching all the rents by book' do
      let!(:book) { create(:book) }
      let!(:rents) { create_list(:rent, 3, book: book) }

      before do
        get :index, params: { book_id: book.id }
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: UserRentSerializer
        ).to_json

        expect(JSON.parse(response.body)['page']).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'When create a rent' do
      let!(:book) { create(:book) }
      let!(:from) { Faker::Date.between(2.days.ago, Time.zone.today) }
      let!(:to) { Faker::Date.between(Time.zone.today, 10.days.from_now) }

      before do
        post :create, params: { user_id: user.id, book_id: book.id, from: from, to: to }
      end

      it 'responses with the rent created json' do
        expected = UserRentSerializer.new(Rent.last).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When create a rent without a book' do
      let!(:from) { Faker::Date.between(2.days.ago, Time.zone.today) }
      let!(:to) { Faker::Date.between(Time.zone.today, 10.days.from_now) }

      before do
        post :create, params: { user_id: user.id, from: from, to: to }
      end

      it 'responds with not_found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'When create a rent without a from date' do
      let!(:book) { create(:book) }
      let!(:to) { Faker::Date.between(Time.zone.today, 10.days.from_now) }

      before do
        post :create, params: { user_id: user.id, book_id: book.id, to: to }
      end

      it 'responds with not_found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'When create a rent without a to date' do
      let!(:book) { create(:book) }
      let!(:from) { Faker::Date.between(2.days.ago, Time.zone.today) }

      before do
        post :create, params: { user_id: user.id, book_id: book.id, from: from }
      end

      it 'responds with not_found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
