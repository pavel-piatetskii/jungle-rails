class Admin::DashboardController < ApplicationController

  name = ENV['HTTP_AUTH_USERNAME']
  password = ENV['HTTP_AUTH_PASSWORD']
  http_basic_authenticate_with name: name, password: password

  def show
    @product_count = Product.all.count
    @category_count = Category.all.count
  end

end
