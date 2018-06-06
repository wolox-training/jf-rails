module Api
  module V1
    class RentsController < ApiController
      before_action :authenticate_user!

      # Summary: List rents of the user or book
      def index
        rents = Rent.where(user_id: params['user_id']) if params['user_id'].present?
        rents = Rent.where(book_id: params['book_id']) if params['book_id'].present?
        render_paginated(filtrate(rents), each_serializer: UserRentSerializer)
      end

      # Summary: Create a rent by a user request
      def create
        rent = Rent.create(user: current_user,
                           book: Book.find(params['book_id']),
                           from: params['from'],
                           to: params['to'])
        render(json: rent, serializer: UserRentSerializer)
      end
    end
  end
end
