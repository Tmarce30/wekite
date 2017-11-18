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
  after_create :set_avatar

  validates :description, presence: true
  validates :address, presence: true
  validates :name, presence: true
  # validates :avatar, presence: true

  has_attachment  :avatar, accept: [:jpg, :png, :gif]

  def set_avatar
    #build url
    url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{self.latitude},#{self.longitude}&radius=200&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
    #make json request
    json = open(url).read
    json = JSON.parse(json)
    byebug
    #get first result
    results = json["results"].reject {|result| result["photos"].nil? }
    result = results.first
    #get first photo
    unless result.nil?
      result["photos"].each_with_index do |photo, i|
        photo_reference = photo["photo_reference"]
        photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_reference}&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
        picture = Picture.new(photo_urls: [photo_url])
        picture.spot = self
        picture.save!
        if i == 0 && self.avatar.nil?
          self.avatar_url = photo_url
        end
      end
      spot.save!
    end
  end
end
