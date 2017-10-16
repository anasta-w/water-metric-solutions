class CreateFarmBlocks < ActiveRecord::Migration
  def change
    create_table :farm_blocks do |t|
      t.string :name

      t.integer :user_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
