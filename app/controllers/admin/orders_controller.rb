class Admin::OrdersController < Admin::AdminController
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find_by_id(params[:id])
    @order_items = OrderItem.where(:order_id => params[:id])
  end

end