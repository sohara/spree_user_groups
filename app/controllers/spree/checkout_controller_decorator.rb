module Spree
    class CheckoutController < ApplicationController
      private
      def before_address
        @order.bill_address ||= Address.default
        @order.ship_address ||= Address.default
        
        @order.user.create_adjustment_for(@order) if @order.user
      end
    end
end