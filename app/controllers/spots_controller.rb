require 'open-uri'
require 'json'
require 'uri'

class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
    # @spots = Spot.where.not(latitude: nil, longitude: nil)
    json = open("https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(params[:address])}").read
    response = JSON.parse(json)

    coords = response["results"][0]["geometry"]["location"]
    @spots = Spot.near([coords["lat"], coords["lng"]], 2000)

    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "/layouts/partials/infowindow", locals: {spot: spot})
    end
  end

  def show
    @review = Review.new

    json = open("https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(@spot.address)}").read

    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
    end
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    if @spot.save
      redirect_to root_path
      #build url
      url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@spot.latitude},#{@spot.longitude}&radius=200&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
      #make json request
      json = open(url).read
      json = JSON.parse(json)
      #get first result
      results = json["results"].reject {|result| result["photos"].nil? }
      result = results.first
      #get first photo
      unless result.nil?
        result["photos"].each_with_index do |photo, i|
          photo_reference = photo["photo_reference"]
          photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_reference}&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
          picture = Picture.new(photo_urls: [photo_url])
          picture.spot = @spot
          picture.save!
        end
      end
    else
      render :new
    end
  end

  def update
  end

  def edit
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :address, :description, :avatar)
  end
end
