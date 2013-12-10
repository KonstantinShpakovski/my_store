require 'spec_helper'

describe Order do
  it "Calculates the total price of the order" do
    #item1 = Item.new(price: 10)
    #item1 = FactoryGirl.create(:item)
    item1 = create(:item)       # ключ в spec_helper.rb
    #item2 = Item.new(price: 20)
    #item2 = FactoryGirl.create(:item, price:20)
    item2 = create(:item, price:20)

    #order = Order.new
    #order = FactoryGirl.create(:order)
    order = create(:order)
    order.items << item1
    order.items << item2

    order.calculate_total
    #order.total.should == 30
    expect(order.total).to eq(30)
  end

  #it "raises exception if order has no items in it" do
  #  expect( -> {create(:order) }).to raise_exception
  #end
end