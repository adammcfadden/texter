require 'rails_helper'

describe "The message path" do
  it "will let the user add a new message" do
    visit new_message_path
    fill_in "message_from", with: '1234567890'
    fill_in "message_to", with: '1234567890'
    fill_in "message_body", with: 'hey hey hey'
    click_on "Send Message"
    expect(page).to have_content("Message Sent!")
  end

  pending "will fail, and give an error if the user does not fill out all fields" do

  end
end
