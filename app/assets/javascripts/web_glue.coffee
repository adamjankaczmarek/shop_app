class @WebGlue
  constructor: (@useCase, @gui, @storage)->
    
    # Clear gui
    Before(@gui, 'showProductDetails', => @gui.clearScreen())
    Before(@gui, 'showProducts', => @gui.clearScreen())
    Before(@gui, 'showCart', => @gui.clearScreen())
    
    # Show product list
    Before(@useCase, 'showProductList',  => @useCase.setInitialProducts(@storage.getProducts()))
    Before(@useCase, 'showProductList',  => @useCase.setInitialCategories(@storage.getCategories()))
    After(@useCase, 'showProductList', => @gui.showProducts(@useCase.currentProducts))
    After(@useCase, 'showProductList', => @gui.updateCartHelper(@useCase.cart))
    
    # Show products in category
    After(@useCase, 'showCategory', => @gui.showProducts(@useCase.currentProducts))
    
    # Show product details
    After(@useCase, 'showProductDetails', => @gui.showProductDetails(@useCase.currentProduct, @useCase.currentCategory))
    
    # Refresh cart helper after product add
    After(@useCase, 'addProductToCart', => @gui.updateCartHelper(@useCase.cart))
    
    # Show full cart view
    After(@useCase, 'showCart', => @gui.showCart(@useCase.cart))
    
    # Remove product from cart
    After(@useCase, 'removeProductFromCart', => @gui.showCart(@useCase.cart))
    After(@useCase, 'removeProductFromCart', => @gui.updateCartHelper(@useCase.cart))
    
    # Change order item quantity
    After(@useCase, 'subProductFromCart', => @gui.showCart(@useCase.cart))
    After(@useCase, 'subProductFromCart', => @gui.updateCartHelper(@useCase.cart))
    After(@useCase, 'increaseOrderItemQty', => @gui.showCart(@useCase.cart))
    After(@useCase, 'increaseOrderItemQty', => @gui.updateCartHelper(@useCase.cart))
    
    # Searching products
    After(@useCase, 'search', => @gui.showProducts(@useCase.currentProducts))
    
    # Checking out the order
    After(@useCase, 'confirmOrder', => @gui.showCart(@useCase.cart))
    After(@useCase, 'confirmOrder', => @gui.updateCartHelper(@useCase.cart))
    
    
    LogAll(@useCase)
    LogAll(@gui)

