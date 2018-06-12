module Api
  module V1
    class RentsController < ApiController
      before_action :authenticate_user!

      # Summary: List rents of the user or book
      def index
        rents = Rent.where(search_param)
        render_paginated(filtrate(rents), each_serializer: RentSerializer)
      end

      # Summary: show info of a rent
      def show
        rent = Rent.find(params['rent_id'])
        authorize rent
        render(json: rent, serializer: RentSerializer)
      end

      # Summary: Create a rent by a user request
      def create
        rent = Rent.new(creation_params)
        return invalid_params(rent.errors) unless rent.save
        send_mail_on_creation(rent)
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

      # Summary: Send email on creation service
      def send_mail_on_creation(rent)
        RentMailer.success_rent_email(rent.id).deliver_later
      end
    end
  end
end
