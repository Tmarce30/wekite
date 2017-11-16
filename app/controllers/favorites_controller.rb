class FavoritesController < ApplicationController
  before_action :set_spot, only: [:create, :update]

  def index
    @favorites = Favorite.where("user_id = ?", "#{params[:user_id]}")
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.spot = @spot
    @favorite.user = current_user
    if @favorite.save
      flash[:notice] = "#{@spot.name} added to your favorites!"
      redirect_to user_favorites_path(current_user)
    else
      render plain: "ERROR"
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
  end
  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :spot_id)
  end

  def set_spot
    @spot = Spot.find(params[:puppy_id])
  end
end
