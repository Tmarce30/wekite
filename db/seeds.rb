require 'open-uri'
require 'json'

spot = Spot.new(
  name: 'hhh',
  address: 'Rua do Ibama s/n, Jericoacoara',
  description: "Faker::Lorem.paragraph")
spot.save!


# Adding photos to spots
spots = Spot.all

spots.each do |spot|
  #build url
  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{spot.latitude},#{spot.longitude}&radius=200&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
  #make json request
  json = open(url).read
  json = JSON.parse(json)
  #get first result
  results = json["results"].reject {|result| result["photos"].nil? }
  result = results.first
  #get first photo
  first_photo = result["photos"].first
  #get photo reference
  photo_reference = first_photo["photo_reference"]

  #get photo url
  photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_reference}&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
  spot.photo_urls = [ photo_url ]
  spot.save!
end
