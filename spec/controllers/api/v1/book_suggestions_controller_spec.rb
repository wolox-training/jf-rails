require 'rails_helper'

describe Api::V1::BookSuggestionsController do
  describe 'POST #create' do
    context 'When create a book suggestion' do
      let!(:editorial) { Faker::Book.publisher }
      let!(:price)     { Faker::Commerce.price }
      let!(:author)    { Faker::Book.author }
      let!(:title)     { Faker::Book.title }
      let!(:link)      { Faker::Internet.url }
      let!(:publisher) { Faker::Book.publisher }
      let!(:year)      { Faker::Number.between(1950, Time.zone.today.year) }
      let!(:user)      { create(:user) }

      let!(:params) do
        {
          editorial: editorial,
          price: price,
          author: author,
          title: title,
          link: link,
          publisher: publisher,
          year: year,
          user_id: user.id
        }
      end

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
      let!(:editorial) { Faker::Book.publisher }
      let!(:price)     { Faker::Commerce.price }
      let!(:author)    { Faker::Book.author }
      let!(:title)     { Faker::Book.title }
      let!(:link)      { Faker::Internet.url }
      let!(:publisher) { Faker::Book.publisher }
      let!(:year)      { Faker::Number.between(1950, Time.zone.today.year) }

      let!(:params) do
        {
          editorial: editorial,
          price: price,
          author: author,
          title: title,
          link: link,
          publisher: publisher,
          year: year
        }
      end

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

    context 'When create a rent without an author' do
      let!(:editorial) { Faker::Book.publisher }
      let!(:price)     { Faker::Commerce.price }
      let!(:title)     { Faker::Book.title }
      let!(:link)      { Faker::Internet.url }
      let!(:publisher) { Faker::Book.publisher }
      let!(:year)      { Faker::Number.between(1950, Time.zone.today.year) }
      let!(:user)      { create(:user) }

      let!(:params) do
        {
          editorial: editorial,
          price: price,
          title: title,
          link: link,
          publisher: publisher,
          year: year,
          user_id: user.id
        }
      end

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
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

    context 'When create a rent without title' do
      let!(:editorial) { Faker::Book.publisher }
      let!(:price)     { Faker::Commerce.price }
      let!(:author)    { Faker::Book.author }
      let!(:link)      { Faker::Internet.url }
      let!(:publisher) { Faker::Book.publisher }
      let!(:year)      { Faker::Number.between(1950, Time.zone.today.year) }
      let!(:user)      { create(:user) }

      let!(:params) do
        {
          editorial: editorial,
          price: price,
          author: author,
          link: link,
          publisher: publisher,
          year: year,
          user_id: user.id
        }
      end

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
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

    context 'When create a rent without link' do
      let!(:editorial) { Faker::Book.publisher }
      let!(:price)     { Faker::Commerce.price }
      let!(:author)    { Faker::Book.author }
      let!(:title)     { Faker::Book.title }
      let!(:publisher) { Faker::Book.publisher }
      let!(:year)      { Faker::Number.between(1950, Time.zone.today.year) }
      let!(:user)      { create(:user) }

      let!(:params) do
        {
          editorial: editorial,
          price: price,
          author: author,
          title: title,
          publisher: publisher,
          year: year,
          user_id: user.id
        }
      end

      subject(:create_request) { post :create, params: params }

      it 'rents not change count' do
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
