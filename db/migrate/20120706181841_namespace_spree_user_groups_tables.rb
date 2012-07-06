class NamespaceSpreeUserGroupsTables < ActiveRecord::Migration
  def up
    rename_table :user_groups, :spree_user_groups
  end

  def down
    rename_table :spree_user_groups, :user_groups
  end
end
