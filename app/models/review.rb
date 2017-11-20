class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :comment, presence: true
  #TODO -- error message
  validates :level_rating, presence: true, inclusion: { in: [1,2,3,4,5] }
end
