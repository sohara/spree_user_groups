module Spree
    class Variant < ActiveRecord::Base
      def price_for_user(user)
        if user && user.user_group
          user.user_group.calculator.compute_item(self)
        else
          price
        end
      end
    end
end