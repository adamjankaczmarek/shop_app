class OrdersController < ApplicationController
  
  def show
    @cart = current_buyer().orders.where(:confirmed => false).last
  end
  
  def add_product
    @product = Product.find_by_id(params[:product_id])
    @order = current_buyer().orders.last
    @existing = OrderItem.where(:order_id => @order.id, :product_id => @product.id).first
    if @existing == nil
      @order_item = OrderItem.create(order_id: @order.id, product_id: @product.id, price: @product.price, quantity: 1)
    else
      @existing.quantity += 1
      @existing.save
    end
    redirect_to(:controller => "orders", :action => "show")
  end
  
  def remove_item
    OrderItem.delete(params[:order_item_id])
    redirect_to(:controller => "orders", :action => "show")
  end
  
  def confirm
    @order = Order.find(params[:id])
    @order.confirmed = true
    @order.save
    Order.create(buyer_id: current_buyer().id, confirmed: false)
    redirect_to(:controller => "shop", :action => "index")
  end
  
end