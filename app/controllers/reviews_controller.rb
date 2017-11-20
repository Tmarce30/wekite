class ReviewsController < ApplicationController
  before_action :set_review, only: [:create, :destroy]

  def create
    @review = Review.new(review_params)
    @review.spot = @spot
    @review.average = @review.average_calc
    if @review.save
      flash[:notice] = "Review saved!"
      redirect_to spot_path(@spot)
    else
      flash[:alert] = @review.errors.full_messages.to_sentence
      redirect_to spot_path(@spot)
    end
  end

  private

  def set_review
    @spot = Spot.find(params[:spot_id])
  end

  def review_params
    params.require(:review).permit(:comment, :level_rating, :environment_rating, :ambience_rating, :access_rating )
  end
end
