class AddHousingToClassifieds < ActiveRecord::Migration[5.1]
  def change
    add_reference :classifieds, :housing, foreign_key: true
  end
end
