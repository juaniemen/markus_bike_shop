class Component < ApplicationRecord
    has_and_belongs_to_many :component_constraints
    has_and_belongs_to_many :component_sets

    def self.component_types
        Component.distinct.pluck(:c_type)
    end

    def self.components_by_component_type(ctype)
        Component.where(c_type: ctype)
    end
end
