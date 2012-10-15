# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all()
Category.delete_all()

categories = Category.create([
    { name: "Road"},
    { name: "Cross"},
    { name: "Fitness"}
])

product = Product.create(name: "Merida Road 901", price: 4567.12)
product.category = Category.find_by_name("Road");
product.save

product2 = Product.create(name: "Trek MADONE 6.9 SSL", price: 35999.54)
product2.category = Category.find_by_name("Road");
product2.save

product3 = Product.create(name: "Merida T3 2012", price: 2456.56)
product3.category = Category.find_by_name("Fitness");
product3.save

product4 = Product.create(name: "Scott Sportster 55 2012", price: 1897.32)
product4.category = Category.find_by_name("Cross");
product4.save    
