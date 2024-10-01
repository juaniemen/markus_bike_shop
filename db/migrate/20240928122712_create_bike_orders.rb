class CreateBikeOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :bike_orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total
      t.text :observations

      t.timestamps
    end
  end
end
