class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.float :longitude
      t.float :latitude

      t.integer :locationable_id, null: false, index: true
      t.string :locationable_type, null: false, index: true
      t.timestamps null: false
    end
  end
end
