class Order < ActiveRecord::Base
  attr_accessible :buyer_id, :confirmed
  belongs_to :buyer
end
