module SpreeUserGroups
  class Engine < Rails::Engine
    engine_name 'spree_user_groups'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    initializer "spree.register.calculators" do |app|
      app.config.spree.calculators.add_class('user_groups')
     
      app.config.spree.calculators.user_groups = [ 
        Spree::Calculator::AdvancedFlatPercent
      ]
    end

    config.to_prepare &method(:activate).to_proc
  end
end