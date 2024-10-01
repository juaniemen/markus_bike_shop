class BikeOrderItem < ApplicationRecord
  belongs_to :bike_order
  belongs_to :component

  attr_accessor :ctype, :warnings

  def c_type
    (component && self.component.c_type) || ctype
  end

  def calculate_price
    return unless component
    combinations = []
    component_ids = bike_order.bike_order_items.map(&:component_id).compact
    if component_ids.length == 1
      self.price = component.price
      return
    end
    for i in (2..component_ids.length)
        combinations << component_ids.combination(i).to_a
    end
    combinations.flatten!(1).reject!{|m| !m.include?(component.id) }
    combinations = combinations.map(&:to_set)
    css = ComponentSet.joins(:components).includes(:components).where(component_source: component.id, components: { id: [ bike_order.bike_order_items.map(&:component_id) ]}).distinct.to_a.reverse
    css_found = css.select{|cs| combinations.include?(cs.components.map(&:id).to_set) }.max{|cs| cs.price}
    if css_found
      self.price = css_found.price
      self.warnings = css_found.description
    else 
      self.price = component.price
    end
  end
end
