class CreateComponentSets < ActiveRecord::Migration[7.2]
  def change
    create_table :component_sets do |t|
      t.bigint :c_source_id
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
