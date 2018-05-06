class Api::V1::ApplicationController < ::ApplicationController
  attr_reader :current_tenant
  protect_from_forgery with: :null_session

  before_action :authenticate_tenant!

  private

  def authenticate_tenant!
    command = AuthorizeApiRequest.call(request.headers)
    if command.failure?
      headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { error: command.errors[:token] }, status: :unauthorized
    else
      @current_tenant = command.result
      @current_tenant.request_track!
    end
  end
end
