require 'open-uri'
require 'json'
require 'uri'

class SpotsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    # @spots = Spot.where.not(latitude: nil, longitude: nil)
    json = open("https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(params[:address])}").read
    response = JSON.parse(json)
    coords = response["results"][0]["geometry"]["location"]
    @spots = Spot.near([coords["lat"], coords["lng"]], 2000)

    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
    end

  end

  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def edit
  end
end
