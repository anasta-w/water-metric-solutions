class CreateMeters < ActiveRecord::Migration
  def change
    create_table :meters do |t|
      t.integer :farm_block_id, null: false, index: true
      t.string :name
      t.integer :calibration_unit
      t.float :output
      t.string :type, null:false

      t.timestamps null: false
    end
  end
end
