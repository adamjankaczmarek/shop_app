class Admin::CategoriesController < Admin::AdminController
  
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find_by_id(params[:id])
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.create(params[:category])
    redirect_to(:controller => "admin/categories", :action => "index")
  end
  
  def update
    @category = Category.find_by_id(params[:id])
    @category.name = params[:category][:name]
    @category.save
    redirect_to(:controller => "admin/categories", :action => "index")
  end
  
  def destroy
    @category = Category.find_by_id(params[:id])
    @category.products.each do |product|
      product.destroy
    end
    @category.destroy
    redirect_to(:controller => "admin/categories", :action => "index")
  end
  
end 