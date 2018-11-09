require 'rails_helper'

RSpec.describe 'When visiting merchants' do
  before(:each) do
    @admin = create(:admin)
    @merch = User.create(name: 'captain crunch',address: '123', city: "denver", state: "CO",zip: 80203, email: "bob",password: 'bob', role: 1)
    @item_1 = @merch.items.create(name: "Fishing Net", description: "useful", price: 100,
      inventory: 1000)
    @item_2 = @merch.items.create(name: "bagels", description: "yum", price: 200,
      inventory: 1000)
  end


  it 'can see merchant stats' do
    visit login_path
    fill_in :email, with: @merch.email
    fill_in :password, with: @merch.password
    click_button 'Log in'

    visit item_path(@item_2)

    expect(page).to have_link("Add Discount")

    click_on "Add Discount"
    expect(current_path).to eq(new_item_discount_path(@item_2))
   
    expect(page).to have_content("Rate")
    expect(page).to have_content("Quantity")

    fill_in :Rate, with: "alot"
    fill_in :Quantity, with: 3
    click_button 'Create Discount'

    fill_in :Rate, with: 20
    fill_in :Quantity, with: 3
    click_button 'Create Discount'
    expect(current_path).to eq(items_path)

    visit item_path(@item_2)
    click_button 'Add to Cart'
    visit carts_path
    expect(page).to have_content("Subtotal: $200.00")
    click_button 'Add 1'
    click_button 'Add 1'
    click_button 'Add 1'

    expect(page).to have_content("Subtotal: $640.00")
  end

end