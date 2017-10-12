class AddSkiResorttoResorts < ActiveRecord::Migration[5.1]
  def change
    add_column :resorts, :ski_resort, :boolean, default: false
    add_index :resorts, :ski_resort
  end
end
