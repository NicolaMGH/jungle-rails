class OrderMailerPreview < ActionMailer::Preview
  def email_receipt
    @order = Order.find_by(id: 1)
    OrderMailer.email_receipt(@order)
  end
end