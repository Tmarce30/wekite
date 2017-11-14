class Spot < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :reviews
  has_many :photos
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :description, presence: true
  validates :address, presence: true
  validates :name, presence: true

  has_attachments :photos
end
