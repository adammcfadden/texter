require 'rails_helper'

describe Message, vcr: true do
  it { should validate_presence_of :to }
  it { should validate_presence_of :from }
  it { should validate_presence_of :body }

  describe "send_sms", vcr: true do
    it "will send a message before creating a message in active record" do
      message = create(:message)
      expect(Message.all.first).to eql message
    end

    it "will fail to send a message if information is incorrect" do
      message = build(:message, to: '123467890')
      message.save
      expect(message.errors.messages[:base]).to eq ["The 'To' number 123467890 is not a valid phone number."]
    end
  end
end
