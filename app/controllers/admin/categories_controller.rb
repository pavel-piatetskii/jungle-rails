class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(name: :asc).all
    @products_count = @categories.ids.map { |id| [id, Product.where(category_id: id).count] }.to_h
  end

  def new
    @category = Category.new
  end

  def create
    @product = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :category], notice: 'Category created!'
    else
      render :new
    end
  end

end
