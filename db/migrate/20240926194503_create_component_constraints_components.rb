class CreateComponentConstraintsComponents < ActiveRecord::Migration[7.2]
  def change
    create_table :component_constraints_components, primary_key: [:component_id, :component_constraint_id] do |t|
      t.references :component, null: false, foreign_key: true
      t.references :component_constraint, null: false, foreign_key: true
    end
  end
end
