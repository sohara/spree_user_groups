Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_user_groups_link_configuration_menu",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => %q{<%= configurations_sidebar_menu_item t(:user_groups), admin_user_groups_path %>},
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => 'auth_admin_user_groups',
                     :insert_after => "[data-hook='admin_user_form_roles']",
                     :partial => 'spree/admin/users/user_group',
                     :original => '8e0dfa155031043981fb0a2e255a615a38543c2f',
                     :disabled => false)