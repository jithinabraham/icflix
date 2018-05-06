class AuthorizeMiddlewareRequest < AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def http_auth_token
    return headers.split(' ').last if headers.present?
    errors.add(:token, 'Missing token') && nil
  end

end
