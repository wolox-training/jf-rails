module Api
  module V1
    class RentsController < ApiController
      before_action :authenticate_user!

      # Summary: List rents of the user or book
      def index
        rents = Rent.where(search_param)
        render_paginated(filtrate(rents), each_serializer: RentSerializer)
      end

      # Summary: Create a rent by a user request
      def create
        rent = Rent.new(creation_params)
        return invalid_params unless rent.save
        render(json: rent, serializer: RentSerializer, status: :created)
      end

      private

      # Summary: Check params on creation service
      def creation_params
        params['user_id'] = current_user.id
        params.require(%i[book_id from to])
        params.permit(:book_id, :user_id, :from, :to)
      end

      # Summary: Build search params
      def search_param
        return { user_id: params['user_id'] } if params['user_id'].present?
        return { book_id: params['book_id'] } if params['book_id'].present?
      end
    end
  end
end
