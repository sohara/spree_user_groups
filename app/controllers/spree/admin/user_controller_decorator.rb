module Spree
  module Admin
    UsersController.class_eval do
      update.before :handle_remove_user_group_params
      update.after :handle_clear_user_group

      private

      def handle_remove_user_group_params

        if params[:user][:user_group_id] == "-1"
          @clear_user_group = true
          params[:user][:user_group_id]=nil
        end
      end

      def handle_clear_user_group
        if @clear_user_group
          @object.user_group_id = nil
          @object.save!
        end
      end
    end
  end
end
