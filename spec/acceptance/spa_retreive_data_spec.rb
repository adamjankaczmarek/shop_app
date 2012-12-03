require "spec_helper"

feature "Spa retreive data" do
  background do
    headers = {'HTTP_ACCEPT' => 'application/json'}
    @client = Bbq::TestClient.new(:headers => headers)
  end
  
  scenario "get products" do
    @product = Product.create(name: "testProduct")
    
    @client.get "/spaProducts.json" do |response|
      response.status.should == 200
      response.body[0]["name"].should == "testProduct"
    end
  end
  
  scenario "get categories" do
    @cat1 = Category.create(name: "testCat1")
    @cat2 = Category.create(name: "testCat2")
    
    @client.get "/spaCategories.json" do |response|
      response.status.should == 200
      categories = response.body.map { |c| c["name"] }
      
      categories.should include(@cat1.name)
      categories.should include(@cat2.name)
      
    end
  end
  
  scenario "save order" do
    @product1 = Product.create(name: "testProduct1", price: 102)
    @product2 = Product.create(name: "testProduct2", price: 13)
    
    items = {
      "0" => 
        {
          "quantity" => "2",
          "product_id" => @product1.id
        },
      "1" =>
        {
          "quantity" => "3",
          "product_id" => @product2.id
        }
    }
    
    
    @client.post "/spaCheckout.json", {items: items} do |response|
      response.status.should == 200
    end
    
    @order = Order.last
    
    @order.order_items.count.should == 2
    @order.order_items[0].product_id.should == @product1.id
    @order.order_items[1].quantity.should == 3
    
    
  end
  
end
