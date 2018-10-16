class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :send_receipt

  def send_receipt
    OrderMailer.email_receipt(self).deliver_later
  end

  def update_products
    self.line_items.each do |item|
      product = Product.find_by(id: item.product_id)
      product.update!(quantity: product.quantity - item.quantity)
    end
  end
end
