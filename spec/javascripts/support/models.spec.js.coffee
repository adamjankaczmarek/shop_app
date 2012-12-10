#= require jquery
#= require underscore
#= require YouAreDaBomb
#= require jstorage.min
#= require handlebars-1.0.0.beta.6
#= require sugar-1.3.min

#= require utils
#= require product_use_case
#= require local_storage
#= require todo_gui
#= require web_glue

describe "Cart", -> 
  describe "empty on start", ->
    beforeEach =>
      @helper = new OrderHelper() 
      @cart = new Order()
      @product1 = new Product(123, "product1", "product1 description", 210, 1)
      
    it "has no products", =>
      expect(@cart.orderItems.length).toBe(0)
    
    it "can have product added", =>
      @helper.addItem @cart, new OrderItem(@product1, 2)
      expect(@cart.orderItems.length).toBe(1)
      expect(@cart.orderItems[0].product.price).toBe(210)

  describe "filled on start", ->
    beforeEach =>
      @product1 = new Product(123, "product1", "product1 description", 210, 1)
      @product2 = new Product(124, "product2", "product2 description", 20, 1)
      @helper = new OrderHelper()
      @cart = new Order()
      @helper.addItem @cart, new OrderItem(@product1, 5)
      @helper.addItem @cart, new OrderItem(@product2, 14)
      
    it "has 19 items", =>
      sum = 0
      for product in @cart.orderItems
        sum += product.quantity
      expect(sum).toBe(19)
      
    it "can have product increased", =>
      @helper.addItem @cart, new OrderItem(@product1, 10)      
      expect(@cart.orderItems[0].quantity).toBe(15);
      sum = 0
      for product in @cart.orderItems
        sum += product.quantity
      expect(sum).toBe(29)
        
    it "can have prouduct decreased", =>
      @helper.subItem @cart, new OrderItem(@product2, 4)      
      expect(@cart.orderItems[1].quantity).toBe(10);
      sum = 0
      for product in @cart.orderItems
        sum += product.quantity
      expect(sum).toBe(15)

    it "can have product implicitly removed", =>
      @helper.subItem @cart, new OrderItem(@product1, 5)
      expect(@cart.orderItems.length).toBe(1);
      expect(@cart.orderItems[0].product).toBe(@product2);
        
    it "can have product explicitly removed", =>
      @helper.deleteItem @cart, new OrderItem(@product1, 5)
      expect(@cart.orderItems.length).toBe(1);
      expect(@cart.orderItems[0].product).toBe(@product2);

