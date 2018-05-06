FactoryBot.define do
  factory :request_tracker do
    date { Time.zone.today }
    request_count { (1..100).to_a.sample }
    tenant
  end
end
