class Message < ActiveRecord::Base
  validates :to, presence: true
  validates :from, presence: true
  validates :body, presence: true

end
