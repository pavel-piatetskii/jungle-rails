require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

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

  scenario "They see all products then go to a product page" do
    # ACT
    visit root_path
    first('article.product').find('header a').click

    # VERIFY
    expect(page).to have_content 'Quantity'
 
    # DEBUG
    save_screenshot
  end
end