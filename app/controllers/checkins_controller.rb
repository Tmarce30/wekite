class CheckinsController < ApplicationController
  before_action :set_spot, only: [:create]

  def create
    @checkin = Checkin.new
    @checkin.spot = @spot
    @checkin.user = current_user
    @checkin.date = Date.parse(checkin_params["date"])

    if @checkin.save
      flash[:notice] = "Checkin done at #{@spot.name}!"
      redirect_to spot_path(@checkin.spot)
    else
      render plain: "ERROR"
    end
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    if @checkin.destroy
      flash[:notice] = "Checkout done!"
      redirect_to spot_path(@checkin.spot)
    else
      render plain: "ERROR"
    end
  end

  private

  def checkin_params
    params.require(:checkin).permit(:user_id, :spot_id, :date)
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end
end

