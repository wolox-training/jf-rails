class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Wor::Paginate
  include Brita
  include Pundit

  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :invalid_params
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def invalid_params(error_detail)
    message = error_detail.to_s if error_detail.class == ActionController::ParameterMissing
    message = error_detail.full_messages.join(' - ') if error_detail.class == ActiveModel::Errors
    render json: { error: 'Invalid params', error_detail: message }, status: :bad_request
  end

  def user_not_authorized
    render json: { error: 'User not authorized' }, status: :unauthorized
  end

  # Set locale for translate
  private def set_locale
    I18n.locale = current_user.locale || I18n.default_locale if current_user
  end
end
