module Spree
  Order.class_eval do
    def user_group_adjustments
      adjustments.where(:originator_type => "Spree::UserGroup")
    end

    # ensure update_prices_per_user is called
    # after every associate_user call
    #
    alias_method :associate_user_without_user_price!, :associate_user!

    def associate_user!(user)
      associate_user_without_user_price! user
      update_prices_per_user
    end


    # ensure update_prices_per_user is called
    # after every add_varaint call
    #
    # Commenting out for now during 2.1 upgrade. :add_varaint no
    # longer part of spree API (use order.contents.add instead)
    #
    # alias_method :add_variant_without_user_price, :add_variant

    # def add_variant(variant, quantity = 1, currency = nil)
    #   current_item = add_variant_without_user_price(variant, quantity, currency)

    #   if update_prices_per_user
    #     current_item.reload
    #   else
    #     current_item
    #   end
    # end


    # changes line_item price value if user has a group discount
    #
    def update_prices_per_user
      return unless self.user.present?

      changes = false
      self.line_items.each do |line_item|
        user_price = line_item.variant.price_for_user(self.user)
        if user_price != line_item.price
          line_item.price = user_price
          line_item.save
          changes = true
        end
      end


      self.reload if changes
      changes
    end
  end
end
