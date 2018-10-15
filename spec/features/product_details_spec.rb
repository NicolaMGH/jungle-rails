require 'rails_helper'

RSpec.feature "Visitor navigate from the home page to the product detail page by clicking on a product", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the details of the product they clicked on" do
    # ACT
    visit root_path

    first('.product').click_link('Details')
    sleep(5)

    # VERIFY
    expect(page).to have_css 'section.products-show'

    # DEBUG
    save_screenshot
  end

end

