class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save!
      flash[:success] = "Your review has been added!"
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @review_delete = Review.find(params[:id]).destroy
    flash[:success] = "Your review has been deleted!"
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

end