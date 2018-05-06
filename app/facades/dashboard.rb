class Dashboard

  def users_count
    @users_count ||= User.count
  end

  def questions_count
    @questions_count || Question.count
  end

  def answers_count
    @answers_count ||= Answer.count
  end

  def tenants_count
    @tenants_count ||= Tenant.count
  end

  def tenants_with_request
    @tenants_with_request ||= Tenant.joins('left outer join request_trackers on
                                           request_trackers.tenant_id = tenants.id')
                              .select('id', 'tenants.name',
                                      'sum(request_trackers.request_count) as requests_count')
                              .group('tenants.id')
  end

end
