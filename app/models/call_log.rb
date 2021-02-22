class CallLog < ApplicationRecord
  validates :call_id, presence: true
  validates :caller_number, presence: true
  def self.daily_summary
    UserMailer.daily_summary_email.deliver_later
  end
end
