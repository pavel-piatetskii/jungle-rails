class Admin::SalesController < ApplicationController

  def index
    @sales = Sale.order(starts_on: :asc).all
  end

end
