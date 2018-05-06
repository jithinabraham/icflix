class Tenant < ApplicationRecord
  has_many :request_trackers
  has_one :daily_tracker, -> { where(date: Time.zone.today) },
          class_name: 'RequestTracker', inverse_of: :tenant

  before_create :generate_api_key

  delegate :request_count, to: :daily_tracker, allow_nil: true

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
    generate_api_key if Tenant.exists?(api_key: api_key)
  end

  def request_track!
    tracker = daily_tracker || build_daily_tracker(date: Time.zone.today)
    tracker.track!
  end

end
