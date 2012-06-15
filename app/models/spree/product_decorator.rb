module Spree
    class Product < ActiveRecord::Base
      def price_for_user(user)
        self.master.price_for_user(user)
      end
    end
end