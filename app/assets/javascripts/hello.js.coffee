class Main
  constructor: ->
    source   = $("#name_tpl").html()
    template = Handlebars.compile(source)
    name = prompt "What's your name", 'Place your name here' 
    $("#container1").html(template({name: name}))
    
$(-> new Main())