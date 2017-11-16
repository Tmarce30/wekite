class ReviewsController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    @review = Review.new(review_params)
    @review.spot = @spot
    if @review.save
      redirect_to spot_path(@spot)
    else
      render spot_path(@spot)
    end
  end

  def update
  end

  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
