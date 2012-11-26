class SpaController < ApplicationController
  def index
    @products = Product.all()
    @categories = Category.all()
  end
  
  def confirmOrder
    @order = Order.create
    @items = params[:items]
    for item in @items
      oItem = OrderItem.create
      oItem.quantity = item[1][:quantity]
      oItem.product_id = item[1][:product_id]
      oItem.order_id = @order.id
      oItem.save
    end
  end
    
  def getProducts
    @products = Product.all()
    respond_to do |format|
      format.json { render :json => @products }
    end 
  end
    
  def getCategories
    @categories = Category.all()
    respond_to do |format|
      format.json { render :json => @categories }
    end
  end
  
end