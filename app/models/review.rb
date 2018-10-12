class Review < ActiveRecord::Base

  belongs_to :product

  validates! :product_id, presence: true
  validates! :user_id, presence: true
  validates! :description, presence: true
  validates! :rating, presence: true
  validates_numericality_of! :rating, only_integer: true
  validates! :rating, inclusion: { in: 1..5 }


end
