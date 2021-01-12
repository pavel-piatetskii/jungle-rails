require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    # validation tests/examples here

    it 'saves a product with all 4 fields filled' do
      @category = Category.new({name: 'test'})
      @category.save

      @product = Product.new({
        name: 'test_product',
        price: 42,
        quantity: 7,
        category_id: Category.find_by_name('test').id
      })
      expect(@product.save).to be(true)
    end

    it 'fails to save a product without name showing related error ' do
      @category = Category.new({name: 'test'})
      @category.save

      @product = Product.new({
        name: nil,
        price: 42,
        quantity: 7,
        category_id: Category.find_by_name('test').id
      })
      @product.save
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end

  end

end
