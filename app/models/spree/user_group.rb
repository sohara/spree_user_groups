module Spree
  class UserGroup < ActiveRecord::Base
    include Spree::Core::CalculatedAdjustments

    has_many :users, :dependent => :nullify
    validates :name, :presence => true

    def calculator_description
      return t(:none) if calculator.nil?
      "#{I18n.t(:price)} - some percentage"
    end
  end
end
