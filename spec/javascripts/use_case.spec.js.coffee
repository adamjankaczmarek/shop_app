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

describe "ProductUseCase", ->
  describe "displayin' products", ->
    beforeEach =>
      @cat1 = new Category(1, "cat1")
      @cat2 = new Category(2, "cat2")
      @cat3 = new Category(3, "cat3")
      @product1 = new Product(121, "product1", "product1 description", 10, 1)
      @product2 = new Product(122, "product2", "product2 description", 20, 1) 
      @product3 = new Product(123, "product3", "product3 description", 30, 2)
      @product4 = new Product(124, "product4", "product4 description", 40, 3)
      @product5 = new Product(125, "product5", "product5 description", 50, 3)
      @useCase = new ProductUseCase()
      @useCase.setInitialProducts([@product1, @product2, @product3, @product4, @product5])
      @useCase.setInitialCategories([@cat1, @cat2, @cat3])
      
    it "is properly initialized", =>
      expect(@useCase.currentProducts.length).toBe(0)
      expect(@useCase.currentProduct).toBe(null)
      expect(@useCase.currentCategory).toBe(null)
      expect(@useCase.cart.orderItems.length).toBe(0)
      expect(@useCase.allProducts.length).toBe(5)
      expect(@useCase.allCategories.length).toBe(3)
      
    it "selects products within chosen category", =>
      @useCase.showCategory(1);
      expect(@useCase.currentProducts.length).toBe(2)
      @useCase.showCategory(2);
      expect(@useCase.currentProducts.length).toBe(1)
      @useCase.showCategory(3);
      expect(@useCase.currentProducts.length).toBe(2)
      expect(@useCase.currentProducts[1]).toBe(@product5)
      
    it "selects one product to display", =>
      @useCase.showProductDetails(@product1)
      expect(@useCase.currentProduct).toBe(@product1)
      @useCase.showProductDetails(@product4)
      expect(@useCase.currentProduct).toBe(@product4)
      @useCase.showProductDetails(@product3)
      expect(@useCase.currentProduct).toBe(@product3)

  describe "manipulating cart", ->
    beforeEach =>
      @cat1 = new Category(1, "cat1")
      @cat2 = new Category(2, "cat2")
      @cat3 = new Category(3, "cat3")
      @product1 = new Product(121, "product1", "product1 description", 10, 1)
      @product2 = new Product(122, "product2", "product2 description", 20, 1) 
      @product3 = new Product(123, "product3", "product3 description", 30, 2)
      @product4 = new Product(124, "product4", "product4 description", 40, 3)
      @product5 = new Product(125, "product5", "product5 description", 50, 3)
      @useCase = new ProductUseCase()
      @useCase.setInitialProducts([@product1, @product2, @product3, @product4, @product5])
      @useCase.setInitialCategories([@cat1, @cat2, @cat3])
          
    it "can add/sub product to cart", =>
      @useCase.addProductToCart(@product1)
      expect(@useCase.cart.orderItems.length).toBe(1)
      expect(@useCase.cart.orderItems[0].product).toBe(@product1)
      @useCase.addProductToCart(@product1)
      @useCase.addProductToCart(@product1)
      @useCase.addProductToCart(@product1)
      @useCase.addProductToCart(@product1)
      expect(@useCase.cart.orderItems[0].quantity).toBe(5)
      @useCase.subProductFromCart(@product1)
      @useCase.subProductFromCart(@product1)
      expect(@useCase.cart.orderItems[0].quantity).toBe(3)
      @useCase.subProductFromCart(@product1)
      @useCase.subProductFromCart(@product1)
      @useCase.subProductFromCart(@product1)
      expect(@useCase.cart.orderItems.length).toBe(0)
    
    it "can remove product from cart", =>
      @useCase.addProductToCart(@product1)
      @useCase.addProductToCart(@product1)
      expect(@useCase.cart.orderItems.length).toBe(1)
      @useCase.removeProductFromCart(new OrderItem(@product1, 2))
      expect(@useCase.cart.orderItems.length).toBe(0)
