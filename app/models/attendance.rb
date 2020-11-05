class Attendance < ApplicationRecord
  after_create :subscription_send
  
  belongs_to :user
  belongs_to :event

  def subscription_send
    event = self.event
    event_admin = event.event_admin
    UserMailer.event_subscription(event_admin, event, user).deliver_now
  end

end
