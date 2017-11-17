class PicturesController < ApplicationController
  def index
  end

  def create
    @picture = find_spot_picture(params[:picture][:spot_id])
    @spot = Spot.find(params[:picture][:spot_id])
    if @picture == []
      @picture = Picture.new(picture_params)
      @picture.user = current_user
      if @picture.save
        redirect_to spot_path(@spot)
      else
        render spot_path(@spot)
      end
    else
      @picture.update(picture_params)
    end
  end

  def destroy
  end

  private

  def find_spot_picture(spot_id)
    @picture = current_user.pictures.where(spot_id: spot_id)
  end

  def picture_params
    params.require(:picture).permit(:spot_id, photos:[])
  end
end
