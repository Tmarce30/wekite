class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :comment, presence: true
  #TODO -- error message
  validates :level_rating, presence: true
  validates :environment_rating, presence: true
  validates :ambience_rating, presence: true
  validates :access_rating, presence: true

  def average_calc
    (self.level_rating + self.environment_rating + self.ambience_rating + self.access_rating).to_f / 4
  end
end

