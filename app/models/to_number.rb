class ToNumber < ActiveRecord::Base
  belongs_to :message

  validates :number, presence: true
end
