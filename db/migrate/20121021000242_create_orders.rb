class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.boolean :confirmed

      t.timestamps
    end
  end
end
