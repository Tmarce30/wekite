require 'open-uri'
require 'json'

class Spot < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :reviews
  has_many :pictures, dependent: :destroy
  has_many :weathers
  has_many :checkins
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :description, presence: true
  validates :address, presence: true
  validates :name, presence: true
  # validates :avatar, presence: true

  has_attachment  :avatar, accept: [:jpg, :png, :gif]


  def average_calc
    reviews = self.reviews
    if reviews.count > 0
      total_rating = 0
      reviews.each do |review|
        total_rating += (review.level_rating + review.environment_rating + review.ambience_rating + review.access_rating).to_f / 4
      end
      avg = total_rating / reviews.count
    else
      avg = 0
    end
    avg
  end

  def level_average_rating
    reviews = self.reviews
    if reviews.count > 0
      total_rating = 0
      reviews.each do |review|
        total_rating += review.level_rating
      end
      avg = total_rating / reviews.count
    else
      avg = 0
    end
    avg
  end

  def environment_average_rating
    reviews = self.reviews
    if reviews.count > 0
      total_rating = 0
      reviews.each do |review|
        total_rating += review.environment_rating
      end
      avg = total_rating / reviews.count
    else
      avg = 0
    end
    avg
  end

  def ambience_average_rating
    reviews = self.reviews
    if reviews.count > 0
      total_rating = 0
      reviews.each do |review|
        total_rating += review.ambience_rating
      end
      avg = total_rating / reviews.count
    else
      avg = 0
    end
    avg
  end

  def access_average_rating
    reviews = self.reviews
    if reviews.count > 0
      total_rating = 0
      reviews.each do |review|
        total_rating += review.access_rating
      end
      avg = total_rating / reviews.count
    else
      avg = 0
    end
    avg
  end
end
