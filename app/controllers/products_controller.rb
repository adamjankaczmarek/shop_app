class ProductsController < ApplicationController
  def index
    @q = Product.search(params[:q])
    @products = @q.result(:distinct => true)
    @is_search = params[:q] != nil 
    
    respond_to do |format|
      format.json { render :json => @products }
    end
     
  end
  
  def show
    @product = Product.find_by_id(params[:id])
  end
  
  def search
    @q = Product.search
  end
  
end
