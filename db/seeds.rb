# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
puts 'Cleaning database'
Dose.delete_all
Ingredient.delete_all
Cocktail.delete_all
# INGREDIENTS
puts 'Creating new ingredients...'
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)
ingredients["drinks"].each do |element|
  ingredient = element["strIngredient1"]
  Ingredient.create!(name: ingredient)
end
mint = Ingredient.create(name: "Mint")
o_juice = Ingredient.create(name: "Orange juice")
olives = Ingredient.create(name: "Olive")
vodka = Ingredient.find_by(name: "Vodka")
rum = Ingredient.find_by(name: "Rum")
gin = Ingredient.find_by(name: "Gin")
puts 'Done!'
# COCKTAILS
puts 'Creating new cocktails...'
mojito = Cocktail.create!(name: "Mojito")
bloody_mary = Cocktail.create!(name: "Bloody Mary")
sex_on_the_beach = Cocktail.create!(name: "Sex on the Beach")
martini = Cocktail.create!(name: "Martini")
puts 'Done!'
# DOSES
puts 'Creating new doses...'
Dose.create!(description: "6 Leaves", cocktail: mojito, ingredient: mint)
Dose.create!(description: "1.5 oz", cocktail: mojito, ingredient: rum)
Dose.create!(description: "4.5 cl", cocktail: bloody_mary, ingredient: vodka)
Dose.create!(description: "9 cl", cocktail: bloody_mary, ingredient: Ingredient.find_by(name: "Tomato juice"))
Dose.create!(description: "1.33 oz", cocktail: sex_on_the_beach, ingredient: vodka)
Dose.create!(description: "1.33 oz", cocktail: sex_on_the_beach, ingredient: o_juice)
Dose.create!(description: "8 cl", cocktail: martini, ingredient: gin)
Dose.create!(description: "4 cl", cocktail: martini, ingredient: Ingredient.find_by(name: "Dry Vermouth"))
Dose.create!(description: "1", cocktail: martini, ingredient: olives)

puts "Adding photos!"

mojito_file = URI.open('https://www.thespruceeats.com/thmb/MqGv7imLKyo0hh5be9SKDdLxtH8=/668x668/smart/filters:no_upscale()/mojito-5a8f339fba61770036ec61d8.jpg')
mojito.photo.attach(io: mojito_file, filename: 'mojito.jpg', content_type: 'image/png')

bloody_file = URI.open('https://i0.wp.com/www.crowdedkitchen.com/wp-content/uploads/2020/08/bloody-mary-bar.jpg')
bloody_mary.photo.attach(io: bloody_file, filename: 'bloody_mary.jpg', content_type: 'image/png')

sex_file = URI.open('https://noseychef.com/wp-content/uploads/2018/07/IMG_3744.jpg')
sex_on_the_beach.photo.attach(io: sex_file, filename: 'sex_on_the_beach.jpg', content_type: 'image/png')

martini_file = URI.open('https://www.simplejoy.com/wp-content/uploads/2018/04/dirty_martini.jpg')
martini.photo.attach(io: martini_file, filename: 'martini.jpg', content_type: 'image/png')
puts 'Done!'
