class CreateBikeOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :bike_order_items do |t|
      t.references :bike_order, null: false, foreign_key: true
      t.references :component, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
