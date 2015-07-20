require 'rails_helper'

describe ToNumber do
  it { should belong_to :message }
  it { should validate_presence_of :number }
end
