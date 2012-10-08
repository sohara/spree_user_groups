module Spree
  Adjustment.class_eval do
    def user_group
      where(:originator_type => 'Spree::UserGroup')
    end
  end
end
