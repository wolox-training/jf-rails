class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  include Brita

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :invalid_params

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def invalid_params
    render json: { error: 'Invalid params' }, status: :bad_request
  end
end
