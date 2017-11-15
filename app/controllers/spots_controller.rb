class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
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
