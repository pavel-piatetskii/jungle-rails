require 'rails_helper'

RSpec.feature "Visitor adds a product to the cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    3.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products then add one product to the cart and the cart's counter changes to 1" do
    # ACT
    visit root_path
    first('article.product').click_on 'Add'

    # VERIFY
    expect(page).to have_content 'My Cart (1)'
 
    # DEBUG
    save_screenshot
  end
end