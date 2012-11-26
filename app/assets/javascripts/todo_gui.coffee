class @WebGui
  constructor: ->
    @productElements = []
    @cartElements = []
    
  clearScreen: =>
    $("#viewsContainer div").hide().html("") 

  prepareTemplateWithData: (templateID,data) =>
    source = $("#"+templateID).html()
    template = Handlebars.compile(source)
    html = template(data)
    element = $(html)


  addNewProduct: (product) =>
    element = @prepareTemplateWithData("productOnList_tpl", {product: product})
    @productElements.push(element)
    $("#productsList").append(element)
    $("#productsList").fadeIn()
    element.find(".toggle").click( => useCase.showProductDetails(product))
  
  addNewOrderItem: (orderItem) =>
    element = @prepareTemplateWithData("cartProduct_tpl", {orderItem: orderItem, totalPrice: orderItem.product.price * orderItem.quantity})
    element.find(".removeFromCart").click( => useCase.removeProductFromCart(orderItem))
    element.find(".increaseItem").click( => useCase.increaseOrderItemQty(orderItem.product))
    element.find(".decreaseItem").click( => useCase.subProductFromCart(orderItem.product))
    @cartElements.push(element)
  
  showProductDetails: (product, category) =>
    element = @prepareTemplateWithData("singleProduct_tpl", {product: product, category: category})
    element.find(".showCategory").click( => useCase.showCategory(category.id))
    element.find(".addToCart").click( => useCase.addProductToCart(product))
    $("#productView").append(element)
    $("#productView").fadeIn()
    
  showProducts: (products) =>
    search = @prepareTemplateWithData("searchForm_tpl")
    $("#productsList").append(search)
    @productElements = []
    for product in products
      @addNewProduct(product)
    
  updateCartHelper: (cart) =>
    totalPrice = 0
    totalQuantity = 0
    for orderItem in cart.orderItems
      totalPrice += orderItem.product.price * orderItem.quantity
      totalQuantity += orderItem.quantity
    element = @prepareTemplateWithData("cartHelper_tpl",{totalPrice: totalPrice, quantity: totalQuantity})
    element.find(".showFullCart").click( => useCase.showCart())
    $("#cartHelper").html(element).fadeIn()
  
  showCart: (cart) =>
    @cartElements = []
    for orderItem in cart.orderItems
      @addNewOrderItem(orderItem)
    console.log(@cartElements)
    element = @prepareTemplateWithData("cart_tpl", null )
    element.find(".backToMainPage").click( => useCase.showProductList() )
    element.find(".confirmOrder").click( => useCase.confirmOrder() )
    for cartElement in @cartElements
      element.find("tbody").append(cartElement)
    $("#cartView").html(element).fadeIn()
    
  findTaskElement: (task) => @taskElements.find((taskElement) -> taskElement.task == task)

  showAlert: -> alert("storage created")
