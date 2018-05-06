class RequestTracker < ApplicationRecord
  belongs_to :tenant
  validates :date, presence: true

  def track!
    self.request_count += 1
    save!
  end
end
