module Spree
  Order.class_eval do
    def user_group_adjustments
      adjustments.where(:originator_type => "Spree::UserGroup")
    end

    # Associates the specified user with the order and destroys any previous association with guest user if necessary.
    def associate_user!(user)
      self.user = user
      self.email = user.email
      
      # Create adjustment for user group
      self.user.create_adjustment_for(self)
      
      # disable validations since this can cause issues when associating an incomplete address during the address step
      save(:validate => false)

      # this is SO INCREDIBLY CRITICAL!  if you don't do this, the adjustment, for
      # some reason, has had it's amount stripped immediately after creation above
      self.update! 
    end

    def item_total_for_user
      if user && user.user_group
        item_total - user_group_adjustments.all.inject(0) {|sum, adj| sum += adj.amount}.abs
      else
        item_total
      end
    end

    def has_only_user_group_adjustments?
      price_adjustments.all? {|adj| adj.originator_type == 'Spree::UserGroup'}
    end
  end
end
