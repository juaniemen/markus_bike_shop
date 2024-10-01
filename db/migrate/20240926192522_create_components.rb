class CreateComponents < ActiveRecord::Migration[7.2]
  def change
    create_table :components do |t|
      t.string :name
      t.text :description
      t.string :c_type
      t.float :price

      t.timestamps
    end
  end
end
