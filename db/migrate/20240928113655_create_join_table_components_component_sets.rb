class CreateJoinTableComponentsComponentSets < ActiveRecord::Migration[7.2]
  def change
    create_join_table :components, :component_sets do |t|
      t.index [:component_id, :component_set_id]
      # t.index [:component_set_id, :component_id]
    end
  end
end
