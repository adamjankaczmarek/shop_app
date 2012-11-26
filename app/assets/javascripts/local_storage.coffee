class @LocalStorage
  constructor: (@namespace) ->
    @set("products", ApiAccess.getProducts())
    @set("categories", ApiAccess.getCategories())
    
  set: (key, value) =>
    console.log(value)
    $.jStorage.set("#{@namespace}/#{key}", value)

  get: (key) =>
    $.jStorage.get("#{@namespace}/#{key}")
  
  getCategories: =>
    @get("categories").map( (categoryData) =>
      category = new Category(categoryData.id, categoryData.name)
      console.log(category)
      return category  
    )
  
  getProducts: =>
    @get("products").map( (productData) =>
      product = new Product(productData.id, productData.name, productData.description, productData.price, productData.category_id)
      console.log(product)
      return product
    )
  
  remove: (key) =>
    $.jStorage.deleteKey("#{@namespace}/#{key}")

  flush: =>
    for key in $.jStorage.index()
      if key.match("^#{@namespace}")
        $.jStorage.deleteKey(key)
