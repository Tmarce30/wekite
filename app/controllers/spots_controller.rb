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
          if i == 0 && spot.avatar.nil?
            spot.avatar_url = photo_url
          else
            picture = Picture.new(photo_urls: [photo_url])
            picture.spot = spot
            picture.save!
        end
      end
    end
    if @spot.save
      redirect_to root_path
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
end
