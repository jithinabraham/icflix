class ApiIntervalLimitter < Rack::Throttle::Interval
  LIMIT = 100
  attr_reader :api_request

  def minimum_interval
    if tenant_request_exceed?
      @min ||= 0.1
    else
      super
    end
  end

  def allowed?(request)
    @api_request = request
    super
  end

  def tenant_request_exceed?
    if api_request && tenant.present?
      tenant.request_count.to_i <= LIMIT
    else
      false
    end
  end

  def tenant
    @tenant ||= begin
                  command = AuthorizeMiddlewareRequest.call(api_request.env['HTTP_AUTHORIZATION'])
                  return command.result if command.success?
                  nil
                end
  end
end
