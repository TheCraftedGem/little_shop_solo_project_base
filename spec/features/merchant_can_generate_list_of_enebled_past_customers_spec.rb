require "rails_helper"
RSpec.describe "merchant sees list of past customers" do
  it 'shows customer emails' do
    user_1, user_2, user_3, user_4 = create_list(:user, 4)
    merchant_1, merchant_2, merchant_3, merchant_4 = create_list(:merchant, 4)
    item_1 = create(:item, user: merchant_1)
    item_2 = create(:item, user: merchant_2)
    item_3 = create(:item, user: merchant_3)
    item_4 = create(:item, user: merchant_4)
    item_5 = create(:item, user: merchant_1)
    item_6 = create(:item, user: merchant_2)
    item_7 = create(:item, user: merchant_3)
    item_8 = create(:item, user: merchant_4)

    order = create(:completed_order, user: user_1)
    create(:fulfilled_order_item, order: order, item: item_1, price: 20000, quantity: 1)
    create(:fulfilled_order_item, order: order, item: item_5, price: 20000, quantity: 1)

    order = create(:completed_order, user: user_2)
    create(:fulfilled_order_item, order: order, item: item_1, price: 20000, quantity: 1)
    create(:fulfilled_order_item, order: order, item: item_5, price: 20000, quantity: 1)

    order = create(:completed_order, user: user_3)
    create(:fulfilled_order_item, order: order, item: item_1, price: 20000, quantity: 1)
    create(:fulfilled_order_item, order: order, item: item_5, price: 20000, quantity: 1)

    expect(merchant_1.customer_emails).to eq([user_1.email, user_2.email, user_3.email])
  end

  it 'shows emails of non customers' do
    user_1, user_2, user_3, user_4 = create_list(:user, 4)

    merchant_1 = create(:merchant)

    item_1 = create(:item, user: merchant_1)

    order = create(:completed_order, user: user_1)
    create(:fulfilled_order_item, order: order, item: item_1, price: 20000, quantity: 1)

    order = create(:completed_order, user: user_1)
    create(:fulfilled_order_item, order: order, item: item_1, price: 20000, quantity: 1)

    order = create(:completed_order, user: user_1)
    create(:fulfilled_order_item, order: order, item: item_1, price: 20000, quantity: 1)

    expect(merchant_1.non_customers).to eq([user_2.email, user_3.email, user_4.email])
  end
end


# 