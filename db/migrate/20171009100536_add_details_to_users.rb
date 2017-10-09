class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_name, :string
    add_index :users, :last_name
    add_column :users, :first_name, :string
    add_index :users, :first_name
    add_column :users, :civility, :string
    add_column :users, :pro_account, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
