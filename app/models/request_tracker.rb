class RequestTracker < ApplicationRecord
  belongs_to :tenant

  def track!
    self.request_count += 1
    save!
  end
end
