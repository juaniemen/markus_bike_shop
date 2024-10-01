class ComponentSet < ApplicationRecord
    has_and_belongs_to_many :components
    belongs_to :component_source, foreign_key: 'c_source_id', class_name: 'Component'
end
