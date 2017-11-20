class Checkin < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :date, presence: true
end
