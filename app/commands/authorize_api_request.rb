class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    tenant
  end

  private

  attr_reader :headers

  def tenant
    @tenant ||= Tenant.find_by(api_key: http_auth_token) if http_auth_token
    @tenant || errors.add(:token, 'Invalid token') && nil
  end

  def http_auth_token
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
    errors.add(:token, 'Missing token') && nil
  end
end
