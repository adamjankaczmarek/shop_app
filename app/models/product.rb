class Product < ActiveRecord::Base
  attr_accessible :name, :price
  belongs_to :category
end
