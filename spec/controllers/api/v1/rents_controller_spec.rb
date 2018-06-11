require 'rails_helper'

describe Api::V1::RentsController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the rents by user' do
      let!(:rents_other_user) { create_list(:rent, 3) }
      let!(:rents) { create_list(:rent, 3, user: user) }

      before do
        get :index, params: { user_id: user.id }
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: RentSerializer
        ).to_json

        expect(JSON.parse(response.body)['page']).to eq(JSON.parse(expected))
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching all the rents by book' do
      let!(:book) { create(:book) }
      let!(:rents_other_book) { create_list(:rent, 3) }
      let!(:rents) { create_list(:rent, 3, book: book) }

      before do
        get :index, params: { book_id: book.id }
      end

      it 'responses with the books json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, serializer: RentSerializer
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
      let!(:params) { { user_id: user.id, book_id: book.id, from: from, to: to } }

      subject(:create_request) { post :create, params: params }

      it 'responses with the rent created json' do
        create_request
        expected = RentSerializer.new(Rent.last).to_json
        expect(JSON.parse(response.body)).to eq(JSON.parse(expected))
      end

      it 'rents change count by one' do
        expect { create_request }.to change { Rent.count }.by(1)
      end

      it 'responds with 200 status' do
        create_request
        expect(response).to have_http_status(:created)
      end

      it 'Enqueues a mailer job' do
        expect { create_request }.to change { Sidekiq::Worker.jobs.size }.by(1)
      end
    end

    context 'When create a rent without a book' do
      let!(:from) { Faker::Date.between(2.days.ago, Time.zone.today) }
      let!(:to) { Faker::Date.between(Time.zone.today, 10.days.from_now) }
      let!(:params) { { user_id: user.id, from: from, to: to } }

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
        expect { create_request }.not_to(change { Rent.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When create a rent without a from date' do
      let!(:book) { create(:book) }
      let!(:to) { Faker::Date.between(Time.zone.today, 10.days.from_now) }
      let!(:params) { { user_id: user.id, book_id: book.id, to: to } }

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
        expect { create_request }.not_to(change { Rent.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When create a rent without a to date' do
      let!(:book) { create(:book) }
      let!(:from) { Faker::Date.between(2.days.ago, Time.zone.today) }
      let!(:params) { { user_id: user.id, book_id: book.id, from: from } }

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
        expect { create_request }.not_to(change { Rent.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When create a rent with from after to date' do
      let!(:book) { create(:book) }
      let!(:from) { Faker::Date.between(Time.zone.tomorrow, 10.days.from_now) }
      let!(:to) { Faker::Date.between(2.days.ago, Time.zone.today) }
      let!(:params) { { user_id: user.id, book_id: book.id, from: from, to: to } }

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
        expect { create_request }.not_to(change { Rent.count })
      end

      it 'responds with bad_request status' do
        create_request
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
