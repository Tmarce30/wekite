class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :destroy, :update]
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @spots = Spot.near(params["address"], 2000)

    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "/layouts/partials/infowindow", locals: {spot: spot})
      marker.title(spot.id.to_s)
    end
  end

  def show

    if current_user
      @favorite = current_user.favorites.where(spot_id: params[:id]).first
      @favorite = Favorite.new if @favorite.nil?
    else
      @favorite = Favorite.new
    end

    if current_user
      @checkin = current_user.checkins.where(spot_id: params[:id]).first
      @checkin = Checkin.new if @checkin.nil?
    else
      @checkin = Checkin.new
    end

    @picture = Picture.new
    @review = Review.new
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
    end
    @possible_dates = build_possible_dates
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    if @spot.save
      redirect_to spot_path(@spot)
    else
      render :new
    end
  end

  def update
    @spot.update(spot_params)
    if @spot.save
      redirect_to spot_path(@spot)
    else
      render :edit
    end
  end

  def edit
  end

  def weather
    puts "weather"
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :address, :description, :avatar)
  end

  def build_possible_dates
    possible_dates = []
    for offset in 0..6
      possible_dates << (Date.today + offset).strftime("%A, %b %d")
    end
    return possible_dates
  end
end
