if ::Rails.version < "3.1" || !::Rails.application.config.assets.enabled
  module SpreeUserGroups
    module Generators
      class InstallGenerator < Rails::Generators::Base

        def add_stylesheets
          inject_into_file "app/assets/stylesheets/admin/all.css", " *= require formtastic\n", :before => /\*\//, :verbose => true
        end

        def add_migrations
          run 'rake railties:install:migrations FROM=spree_user_groups'
        end

        def run_migrations
           res = ask "Would you like to run the migrations now? [Y/n]"
           if res == "" || res.downcase == "y"
             run 'rake db:migrate'
           else
             puts "Skiping rake db:migrate, don't forget to run it!"
           end
        end
      end
    end
  end
else
  module SpreeUserGroups
    module Generators
      class InstallGenerator < Rails::Generators::Base
        def add_migrations
          run 'rake railties:install:migrations FROM=spree_user_groups'
        end

        def run_migrations
           res = ask "Would you like to run the migrations now? [Y/n]"
           if res == "" || res.downcase == "y"
             run 'rake db:migrate'
           else
             puts "Skiping rake db:migrate, don't forget to run it!"
           end
        end

      end
    end
  end
end