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
    end

  end

  def show
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    if @spot.save
      redirect_to root_path
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
