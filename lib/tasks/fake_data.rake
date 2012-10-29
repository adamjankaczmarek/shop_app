namespace :db do
  namespace :development do
    desc "Create user records in the development database."

    task :fake_products => :environment do
      require 'faker'
    
      
      Category.delete_all()
      Product.delete_all()


      categories = []
      20.times do
        category = Category.new(:name => Faker::Name.last_name)
        category.save
        categories << category
      end
      
      100.times do
        product = Product.new(
          :name => Faker::Name.last_name + Faker::Name.last_name, 
          :description => Faker::Lorem.words(20..50).join(" "),
          :price => rand * rand * 1000
        )
        product.category = categories[rand*20]
        product.save         
      end
      
    end
  end
end