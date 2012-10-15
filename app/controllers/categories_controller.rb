class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_id(params[:id])
    @products = @category.products
  end
end
