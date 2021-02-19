class UserMailer < ApplicationMailer
  default from: 'no-reply@talkdesk.com', to: 'aktfrikshun@gmail.com'

  def notification_email
    @call_log = params[:call_log]
    mail(subject: 'TalkDesk End Call Notification')
  end

  def daily_summary_email
    mail(subject: 'TalkDesk Daily Summary')
  end
end
