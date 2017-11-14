class SpotsController < ApplicationController
  def index
    @spots = Spot.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
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
