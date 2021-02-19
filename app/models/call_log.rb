class CallLog < ApplicationRecord
  def self.daily_summary
    UserMailer.daily_summary_email.deliver_later
  end
end
