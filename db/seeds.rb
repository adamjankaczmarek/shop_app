# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
products = Product.create([
    { name: "Merida Road 901 Full Ultegra", price: 4567.12}, 
    { name: "Merida T3 2012", price: 2456.56},
    { name: "Scott Sportster 55 2012", price: 1897.32 }])