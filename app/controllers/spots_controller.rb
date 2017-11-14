class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    if @spot.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
  end

  def update
  end

  def edit
  end

  private

  def set_puppy
    @spot = Spot.find(params[:id])
  end

  def puppy_params
    params.require(:spot).permit(:name, :breed, :photo, :address, :description)
  end

end
