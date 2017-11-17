class FavoritesController < ApplicationController
  before_action :set_spot, only: [:create, :update]

  def index
    @favorites = Favorite.where("user_id = ?", "#{params[:user_id]}")
  end

  def create
    @favorite = Favorite.new
    @favorite.spot = @spot
    @favorite.user = current_user
    if @favorite.save
      flash[:notice] = "#{@spot.name} added to your favorites!"
      redirect_to spot_path(@favorite.spot)
    else
      render plain: "ERROR"
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    if @favorite.destroy
      flash[:notice] = "Deleted from your favorites!"
      redirect_to params[:redirect_url]
    else
      render plain: "ERROR"
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :spot_id)
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end
end
