require 'rails_helper'

describe Message, vcr: true do
  it { should validate_presence_of :to }
  it { should validate_presence_of :from }
  it { should validate_presence_of :body }

  pending "will send a message before creating a message in active record" do
    message = create(:message)
    expect(Message.all).to eql [message]
  end
end
