require "test_helper"

class ObtainDatumTest < Bbq::TestCase
  background do
    headers = {'HTTP_ACCEPT' => 'application/json'}
    @client = TestClient.new(:headers => headers)
  end
  
  scenario "get products" do
    @client.get "/spa/getProducts" do |response|
      assert_equal 200, response.status
      assert_equal "jaksnazwa", response.body["products"][0]["name"]
    end
  end
  
  
  
  
end
