module Spree
  class Admin::UserGroupsController < Admin::ResourceController
    before_filter :load_data

    private
    def build_object
      @object ||= end_of_association_chain.send((parent? ? :build : :new), object_params)
      @object.calculator = params[:user_group][:calculator_type].constantize.new if params[:user_group]
    end

    def load_data
      @calculators = Spree::UserGroup.calculators
      @user_groups = Spree::UserGroup.all
    end
  end
end