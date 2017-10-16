class CreateWaterTanks < ActiveRecord::Migration
  def change
    create_table :water_tanks do |t|
      t.integer :farm_block_id, null:false, index: true
      t.float :height, null: false
      t.integer :capacity
      t.string :name, default: "Water Tank"
      t.string :device_EUI, null: false

      t.timestamps null: false
    end
  end
end
