module BikeOrdersHelper

        # Given a set of selected components, filter those that cannot be selected in the next step
        def components_not_available(components_selected)
            return components_not_available_full_form(components_selected) if components_selected.length == Component.component_types.length
            if components_selected.blank?
                ccs = ComponentConstraint.includes(:components).joins(:components).distinct
            else
                ccs = ComponentConstraint.joins(:components).where(:components => { id: [ components_selected.map(&:id) ]}).distinct
            end
            
            result = ccs.inject([]) do |memo, cc|
                diff = cc.components - components_selected
                (memo = memo+diff) if diff.length == 1
                memo
            end.uniq
            result
        end
        
        def components_not_available_full_form(components_selected)
            result = components_selected.inject(Set[]) do |memo, c|
                c_aux = components_selected-[c]
                memo = memo+components_not_available(c_aux)
                memo
            end
            result
        end

end
