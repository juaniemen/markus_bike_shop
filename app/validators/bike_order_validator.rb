class BikeOrderValidator < ActiveModel::Validator
    def validate(record)
        validate_constraints(record)
        validate_prices(record)
    end

    def validate_constraints(record)
        if record.bike_order_items.empty? || record.bike_order_items.map(&:component_id).compact.empty?
            record.errors.add(:bike_order, "To buy a bike, select every component")
        elsif record.bike_order_items.map(&:component_id).any?(&:blank?)
            record.errors.add(:custom, "To buy a bike, select every component")
        else
            combinations = []
            component_ids = record.bike_order_items.map(&:component_id)
            for i in (1..component_ids.length)
                combinations << component_ids.combination(i).to_a
            end
            combinations.flatten!(1)
            ccs = ComponentConstraint.joins(:components).where(:components => { id: [ record.bike_order_items.map(&:component_id) ]})
            ccs_component_ids = ccs.map{|m| m.components.map(&:id) }
            invalid_combinations = combinations.map(&:to_set) & ccs_component_ids.map(&:to_set)
            if invalid_combinations.present?
                invalid_combinations.each do |ic|
                    message = "Following components are not compatible: " +
                    ic.map{|ic2|  c = Component.find(ic2); c.c_type + ": "+ c.name }.join(' / ')
                    record.errors.add(:custom, message)
                end
            end
        end
    end

    def validate_prices(record)
        dummy_order = record.clone
        dummy_order.bike_order_items = record.bike_order_items.map{|boi| boi.clone }
        dummy_order.calculate_bike_order_prices!
        result = dummy_order.bike_order_items.zip(record.bike_order_items).all? do |boi_d, boi|
            boi_d.price == boi.price
        end
        record.errors.add(:custom, "Prices were changed during the order process, reload the page and try again") unless result
    end
end