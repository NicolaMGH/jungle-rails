class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def email_receipt(order)
    @order = order
    mail(to: @order.email, subject: "Jungle order # #{@order.id}")
  end
end
