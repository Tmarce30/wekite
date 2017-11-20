require 'open-uri'
require 'json'

class Spot < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :reviews
  has_many :pictures, dependent: :destroy
  has_many :weathers
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :description, presence: true
  validates :address, presence: true
  validates :name, presence: true
  # validates :avatar, presence: true

  has_attachment  :avatar, accept: [:jpg, :png, :gif]

  def average_ratings
    # create array
    #self.reviews do
  end

end
