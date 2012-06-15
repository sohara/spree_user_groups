module Spree
  module Admin
    UsersHelper.module_eval do
      def list_groups(user)
        user.respond_to?(:groups) ? user.groups.collect { |group| group.name }.join(", ") : []
      end
    end
  end
end