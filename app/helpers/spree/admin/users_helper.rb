module Spree
  module Admin
    module UsersHelper
      def list_groups(user)
        user.respond_to?(:groups) ? user.groups.collect { |group| group.name }.join(", ") : []
      end
    end
  end
end
