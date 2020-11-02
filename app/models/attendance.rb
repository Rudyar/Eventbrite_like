class Attendance < ApplicationRecord
  after_create :
  belongs_to :user
  belongs_to :event

  def subcription_send
    UserMailer.event_subscription.deliver_now
  end

end
