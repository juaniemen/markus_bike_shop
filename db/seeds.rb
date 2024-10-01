# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create(email: 'juanfran@fakemail.com', username: 'juanfran', password: 'juanfran')
User.create(email: 'factorial@fakemail.com', username: 'factorial', password: 'factorial')

components = {"Frame type": ["Full-suspension", "diamond", "step-through"],
"Frame finish": ["Matte", "shiny"],
"Wheels": ["Road wheels", "mountain wheels", "fat bike wheels"],
"Rim color": ["Red", "black", "blue"],
"Chain": ["Single-speed chain", "8-speed chain"]}

components.each do |type, names|
    names.each do |name|
        Component.create!({name: name, description: name + " description", c_type: type, price: rand(20..150)})

    end
end


# Sacar combinaciones ramdom de 2 a 3 componentes para hacer precios especiales
combinations = []
for i in 2..3 do
    combinations << Component.all.to_a.combination(i).to_a
end
combinations.flatten!(1)

subsample = combinations.sample(30).shuffle
constraints = subsample[0..10]
special_prices_combo = subsample[10..-1]

constraints.each do |components|
    cc = ComponentConstraint.new
    incom_code = (('A'..'Z').to_a + ('0'..'9').to_a).sample(4).join('')
    cc.name = "Incompatibildad #{incom_code}"
    cc.components = components
    cc.save
end


special_prices_combo.each do |components|
    price_code = (('A'..'Z').to_a + ('0'..'9').to_a).sample(4).join('')
    cs = ComponentSet.new(price: rand(20..150), description: "Precio especial ##{price_code} para #{components.first.c_type}: #{components.first.name}")
    cs.components = components
    cs.component_source = components.first
    cs.save
end