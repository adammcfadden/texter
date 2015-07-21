require 'rails_helper'


describe 'inbound text message', selenium_test: true do

  it 'will create a new message with the inbound flag and store it' do
    body = "This a test"
    from = "6149168051"
    to = "6149168051"
    RestClient.post(
      "http://localhost:3000/inbound_messages",
      Body: body,
      To:   to,
      From: from
    )
    visit "http://localhost:3000"
    expect(page).to have_content("Inbound Message From: 6149168051")
  end
end
