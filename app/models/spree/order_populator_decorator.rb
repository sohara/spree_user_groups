module Spree
  OrderContents.class_eval do

    alias_method :add_without_user_pricing, :add
    # Get current line item for variant if exists
    # Add variant qty to line_item
    def add(variant, quantity, currency=nil, shipment=nil)
      current_item = add_without_user_pricing(variant, quantity, currency, shipment)

      if update_prices_per_user
        current_item.reload
      else
        current_item
      end

    end

    private

      # changes line_item price value if user has a group discount
      #
      def update_prices_per_user
        return unless order.user.present?
        user = order.user

        changes = false
        order.line_items.each do |line_item|
          user_price = line_item.variant.price_for_user(user)
          if user_price != line_item.price
            line_item.price = user_price
            line_item.save
            changes = true
          end
        end


        order.reload if changes
        changes
      end

  end
end
