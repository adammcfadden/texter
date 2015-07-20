class Message < ActiveRecord::Base
  has_many :to_numbers
  accepts_nested_attributes_for :to_numbers, allow_destroy: true

  validates :from, presence: true
  validates :body, presence: true

  before_create :send_sms

  def self.send_reply(to)
    body = "This is an automatic reply, no one is here to hear your cry"
    from = "6149168051"
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

private
  def send_sms
    begin
      to_numbers.each do |number_object|
        response = RestClient::Request.new(
          method: :post,
          url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
          user: ENV['TWILIO_ACCOUNT_SID'],
          password: ENV['TWILIO_ACCOUNT_TOKEN'],
          payload: { Body: body,
                     To:   number_object.number,
                     From: from }
        ).execute
      end
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
    end
  end
end
