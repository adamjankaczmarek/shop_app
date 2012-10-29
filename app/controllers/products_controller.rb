class ProductsController < ApplicationController
  def index
    @q = Product.search(params[:q])
    @products = @q.result(:distinct => true)
    @is_search = params[:q] != nil 
  end
  
  def show
    @product = Product.find_by_id(params[:id])
  end
  
  def search
    @q = Product.search
  end
  
end
