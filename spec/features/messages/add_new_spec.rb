require 'rails_helper'

describe "The message path", vcr: true do
  it "will let the user add a new message", js: true do
    visit new_message_path
    fill_in "message_from", with: attributes_for(:message)[:from]
    click_on "Add New Number"
    fill_in "Number", with: attributes_for(:to_number)[:number]
    fill_in "message_body", with: attributes_for(:message)[:body]
    click_on "Send Message"
    expect(page).to have_content("Message Sent!")
  end

  it "will fail, and give an error if the user does not fill out all fields", js: true do
    visit new_message_path
    click_on "Add New Number"
    fill_in "Number", with: attributes_for(:to_number)[:number]
    fill_in "message_body", with: attributes_for(:message)[:body]
    click_on "Send Message"
    expect(page).to have_content("can't be blank")
  end
end
