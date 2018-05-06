module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def record_not_found(exception)
    render json: {
      error: {
        code: :not_found,
        message: exception.message
      }
    }, status: :not_found
  end
end
