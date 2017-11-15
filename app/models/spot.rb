class Spot < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :reviews
  has_many :pictures

  validates :description, presence: true
  validates :address, presence: true
  validates :name, presence: true

  has_attachment  :avatar, accept: [:jpg, :png, :gif]
end
