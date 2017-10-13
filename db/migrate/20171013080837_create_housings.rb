class CreateHousings < ActiveRecord::Migration[5.1]
  def change
    create_table :housings do |t|
      
      # Same as in classifieds
      t.string :title
      t.integer :number_of_guests
      t.string :link

      # Additional data
      t.boolean :accepts_home_away_payments
      t.boolean :accepts_offline_payments
      t.boolean :accepts_credit_cards
      t.boolean :integrated_property_manager
      t.boolean :multi_unit_property
      t.boolean :online_bookable
      t.boolean :instant_bookable
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms_full
      t.integer :number_of_bathrooms_half
      t.integer :number_of_bathrooms_toilet_only
      t.integer :number_of_bathrooms_full_and_half
      t.integer :image_count
      t.string :property_name
      t.string :property_type
      t.float :geocode_latitude
      t.float :geocode_longitude
      t.boolean :geocode_exact
      t.float :average_rating
      t.float :scaled_average_rating
      t.integer :review_count
      t.integer :min_stay_range_low
      t.integer :min_stay_range_high

      # Relationships
      t.references :resort, foreign_key: true

      t.timestamps
    end
    
  end
end
