class CreateInflowMeters < ActiveRecord::Migration
  def change
    create_table :inflow_meters do |t|
      t.integer :farm_block_id, null: false, index: true
      t.string :name
      t.integer :calibration_unit
      t.string :device_EUI, null: false
      t.integer :daily_consent

      t.timestamps null: false
    end
  end
end
