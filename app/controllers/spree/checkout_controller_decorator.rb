module Spree
  CheckoutController.class_eval do
    private
    def before_address
      @order.bill_address ||= Address.default
      @order.ship_address ||= Address.default
    end
  end
end
