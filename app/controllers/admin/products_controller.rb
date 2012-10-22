class Admin::ProductsController < Admin::AdminController
  
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find_by_id(params[:id])
    @categories = Category.all
  end
  
  def new
    @product = Product.new
    @categories = Category.all
  end
  
  def create
    @product = Product.create(params[:product])
    redirect_to admin_products_path
  end
  
  def update
    @product = Product.find_by_id(params[:id])
    @product.name = params[:product][:name]
    @product.price = params[:product][:name]
    @product.category = params[:product][:category]
    @product.save
    redirect_to admin_products_path
  end
  
  def destroy
    @product = Product.find_by_id(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end
  
end 