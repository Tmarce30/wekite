class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :destroy, :update, :weather]
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

    @picture = Picture.new
    @review = Review.new
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

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :address, :description, :avatar)
  end
end
