class ReviewsController < ApplicationController
  before_action :set_review, only: [:create, :destroy]

  def create
    @review = Review.new(review_params)
    @review.spot = @spot




    if @review.save
      redirect_to spot_path(@spot)
    else
      redirect_to spot_path(@spot)
    end
  end

  def update

  end

  def destroy
    @review.destroy
    redirect_to spot_path(@spot)
  end

  private

  def set_review
    @spot = Spot.find(params[:spot_id])
  end

  def review_params
    params.require(:review).permit(:level_rating, :comment)
  end
end
