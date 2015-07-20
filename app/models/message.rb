class Message < ActiveRecord::Base

  validates :to, presence: true
  validates :from, presence: true
  validates :body, presence: true

  before_create :send_sms
private
  def send_sms
    response = RestClient::Request.new(
      method: :post,
      url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
      user: ENV['TWILIO_ACCOUNT_SID'],
      password: ENV['TWILIO_ACCOUNT_TOKEN'],
      payload: { Body: body,
                 To:   to,
                 From: from }
    ).execute
  end
end
