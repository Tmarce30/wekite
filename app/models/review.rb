class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :comment, presence: true
  #TODO -- error message
  validates :level_rating, presence: true
  validates :environment_rating, presence: true
  validates :ambience_rating, presence: true
  validates :access_rating, presence: true
end

