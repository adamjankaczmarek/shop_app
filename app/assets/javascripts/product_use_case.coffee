class @ProductUseCase
  constructor: ->
    @allProducts = []
    @allCategories = []
    @currentProducts = []
    @currentProduct = null
    @currentCategory = null
    @cart = new Order()
    @cartHelper = new OrderHelper()
    @api = new ApiAccess()
  
  # Populating allProducts list
  setInitialProducts: (products) =>
    @allProducts = products

  # Populating alLCategories list
  setInitialCategories: (categories) =>
    @allCategories = categories

  # Setting list of displayed products to all
  showProductList: ->
    @currentProducts = @allProducts
  
  # Setting list of displayed products to this belonging to certain category
  showCategory: (category_id) ->
    @currentProducts = @allProducts.filter (product) -> product.category_id == category_id
  
  # Setting current product and category to display
  showProductDetails: (product) =>
    @currentProduct = product
    @currentCategory = @allCategories.find((category) -> category.id = product.category_id)
      
  # Adding product to cart
  addProductToCart: (product) ->
    @cartHelper.addItem(@cart, new OrderItem(product))
  
  # Increasing order item quantity
  increaseOrderItemQty: (product) ->
    @cartHelper.addItem(@cart, new OrderItem(product))
  
  # Subtract product quantity in cart
  subProductFromCart: (product) ->
    @cartHelper.subItem(@cart, new OrderItem(product)) 
    
  # Delete product from cart  
  removeProductFromCart: (orderItem) ->  
    @cartHelper.deleteItem(@cart, orderItem)
  
  # Show detailed view of cart  
  showCart: =>   
  
  # Make order of cart contents
  confirmOrder: =>
    ApiAccess.checkoutOrder(@cart)
    @cart = new Order()
    
  # Search products
  search: (form) =>
    @currentProducts = @allProducts.filter (product) ->  (product.name.indexOf form.productName.value) >= 0
    @currentProducts = @currentProducts.filter (product) ->  (product.description.indexOf form.productDescription.value) >= 0
    @currentProducts = @currentProducts.filter (product) ->  (product.price < form.priceLt.value)
    @currentProducts = @currentProducts.filter (product) ->  (product.price > form.priceGt.value)
      
    
  
# Product class  
class @Product
  constructor: (@id, @name, @description, @price, @category_id) ->
   
# Category class
class @Category
  constructor: (@id, @name) ->

# Order item class - they're items Order consists of
class @OrderItem
  constructor: (@product, @quantity = 1)->

# Order class
class @Order
  constructor: ->
    @orderItems = []

# Order helper class
class @OrderHelper
  addItem: (order, orderItem) ->
    item = order.orderItems.find((item) -> item.product.id == orderItem.product.id)
    if item
      item.quantity += orderItem.quantity
    else
      order.orderItems.push(orderItem)

  subItem: (order, orderItem) ->
    item = order.orderItems.find((item) -> item.product.id == orderItem.product.id)
    if item
      item.quantity -= orderItem.quantity
    if item.quantity <= 0
      @deleteItem(order, item)
    
  deleteItem: (order, orderItem) ->
    order.orderItems.remove(orderItem)
  
class @ApiAccess
  @checkoutOrder: (order) ->
    result = { items: [] }
    for item in order.orderItems
      result.items.push(
        product_id: item.product.id
        quantity: item.quantity
      )
    $.ajax({
      type: "POST",
      url: '/spaCheckout',
      async: false,
      dataType: 'json',
      data: result
    })
  
  @getProducts: ->
    products = []
    $.ajax({
      type: "POST",
      url: '/spaProducts.json',
      async: false,
      dataType: 'json',
      success: (data, status) -> 
        products = data
        console.log(products)
    })
    return products
    
  @getCategories: ->
    categories = []
    $.ajax({
      type: "POST",
      url: '/spaCategories.json',
      async: false,
      dataType: 'json',
      success: (data, status) -> 
        categories = data
        console.log(categories)
    })
    return categories