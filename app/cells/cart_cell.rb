class CartCell < Cell::Rails
  
  def show(args)
    @cart = @current_buyer = args[:current_cart]
    @totalPrice = 0.0
    
    @cart.each do |item|
      @totalPrice += item.price * item.quantity  
    end
    
    render
  end
  
end