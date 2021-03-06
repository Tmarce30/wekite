class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :destroy, :update, :weather]
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @spots = Spot.near(params["address"], 2000)

    if @spots.empty?
      @spots = Spot.all
    end


    @address = params["address"]



    @possible_dates = []
    for offset in 0..6
      date = (Date.today + offset)
      @possible_dates << [date.strftime("%A, %b %d"), date]
    end
    @date = params[:date] || @possible_dates[0][1]

    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow render_to_string(partial: "/layouts/partials/infowindow", locals: {spot: spot, weather: spot.weathers.first, date: @date})
      marker.title(spot.id.to_s)
    end
  end

  def show
    # Favorites
    if current_user
      @favorite = current_user.favorites.where(spot_id: params[:id]).first
      @favorite = Favorite.new if @favorite.nil?
    else
      @favorite = Favorite.new
    end

    # Checkin

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

    @date = params[:weather_date] || @possible_dates[0]

    # Weather
    @weather = @spot.weathers.where(date: @date.to_date).last
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    if @spot.save
      GetWeatherInfo.get_weather(@spot.id)
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

  def get_spot_weather
    weather_date = params[:weather_date].to_date.strftime("%Y-%m-%e")
    @spot = Spot.find(params[:spot_id])
    @weather = Weather.where(spot_id: @spot.id, date: weather_date).last
    respond_to do |format|
      format.js
    end
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
    #("%Y-%m-%e")
  end
end
