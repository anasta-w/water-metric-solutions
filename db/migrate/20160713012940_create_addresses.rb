class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_one, null: false
      t.string :address_two, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :post_code, null: false

      t.integer :farm_block_id, null: false
      t.timestamps null: false
    end
  end
end
