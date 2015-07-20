require 'rails_helper'

describe 'The message path', js: true do
  it 'will let the user add additional to inputs to the form' do
    visit new_message_path
    click_on "Add New Recipent"
    click_on "Add New Recipent"
    expect(page).to have_css('input[type="number"][id="to-recipient-1"]')
    expect(page).to have_css('input[type="number"][id="to-recipient-2"]')
    expect(page).to have_css('input[type="number"][id="to-recipient-3"]')
  end
end
