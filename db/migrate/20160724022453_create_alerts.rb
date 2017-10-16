class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :condition, null: false
      t.integer :value, null: false
      t.string :action, null: false
      t.string :node_attribute, null: false

      t.integer :alertable_id, null:false, index:true
      t.string :alertable_type, null:false, index:true

      t.timestamps null: false
    end
  end
end
