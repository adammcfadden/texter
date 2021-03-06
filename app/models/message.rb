class Message < ActiveRecord::Base
  has_many :to_numbers
  accepts_nested_attributes_for :to_numbers, allow_destroy: true

  validates :from, presence: true
  validates :body, presence: true

  before_create :send_sms

private
  def send_sms
    unless inbound
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
end
