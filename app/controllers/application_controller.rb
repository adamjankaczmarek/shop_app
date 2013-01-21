class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_cart, :current_fakeuser
  
  def current_fakeuser
    cookies[:fakelogin]
  end
  
  def current_buyer
    @current_buyer_id = cookies[:buyer_id]
    @current_buyer = Buyer.find_by_id(@current_buyer_id)
    if @current_buyer == nil
      @current_buyer = Buyer.create
      Order.create(buyer_id: @current_buyer.id, confirmed: false)
      cookies[:buyer_id] = { :value => @current_buyer.id, :expires => 1.week.from_now }
    end
    return @current_buyer
  end
  
  def current_cart
    @current_cart = OrderItem.where(:order_id => current_buyer().orders.where(:confirmed => false).last.id).all
  end
  
end