class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.string  :name
    end

    if table_exists? :users
      change_table :users do |t|
        t.integer :user_group_id
      end
    else
      change_table :spree_users do |t|
        t.integer :user_group_id
      end
    end
  end

  def self.down
    if table_exists? :users

      change_table :users do |t|
        t.remove :user_group_id
      end
    else
      change_table :spree_users do |t|
        t.remove :user_group_id
      end
    end

    drop_table :user_groups
  end
end
