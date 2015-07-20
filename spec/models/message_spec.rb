require 'rails_helper'

describe Message, vcr: true do
  it { should validate_presence_of :to }
  it { should validate_presence_of :from }
  it { should validate_presence_of :body }

  it "will send a message before creating a message in active record" do
    message = create(:message)
    expect(Message.all.first).to eql message
  end
end
