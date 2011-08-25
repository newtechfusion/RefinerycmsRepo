class AddFirstLastNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string, :after => :email
    add_column :users, :first_name, :string, :after => :email
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
