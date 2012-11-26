//= require jquery
//= require underscore
//= require YouAreDaBomb
//= require jstorage.min
//= require handlebars-1.0.0.beta.6
//= require sugar-1.3.min

//= require utils
//= require product_use_case
//= require local_storage
//= require todo_gui
//= require web_glue


class WebTodoApp
  constructor: ->
    useCase = new ProductUseCase()
    window.useCase = useCase
    gui = new WebGui()
    localStorage = new LocalStorage("shop_app")
    glue = new WebGlue(useCase, gui, localStorage)
    useCase.showProductList()
    
$(-> new WebTodoApp())