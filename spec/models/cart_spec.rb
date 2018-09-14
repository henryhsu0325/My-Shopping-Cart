require 'rails_helper'
RSpec.describe Cart, type: :model do
  describe "購物車基本功能" do

  context "一、購物車的商品" do

    it "商品可以放到購物車裡" do
      cart = Cart.new
      cart.add_item 1
      expect(cart.empty?).to be false
    end

    it "同種類的商品放到購物車裡，不會再增加購買項目(CartItem)，而商品的數量會改變" do
      cart = Cart.new
      2.times { cart.add_item(1) }
      4.times { cart.add_item(2) }
      3.times { cart.add_item(3) }
      expect(cart.items.length).to be 3
      expect(cart.items.first.quantity).to be 2
      expect(cart.items.second.quantity).to be 4
      expect(cart.items.third.quantity).to be 3
    end

    it "放在購物車的商品可以取出來" do
      cart = Cart.new
      item1 = Product.create(name:"baseball")
      item2 = Product.create(name:"cellphone")
      2.times { cart.add_item(item1.id) }
      3.times { cart.add_item(item2.id) }

      expect(cart.items.first.product_id).to be item1.id
      expect(cart.items.second.product_id).to be item2.id
      expect(cart.items.first.product).to be_a Product
      expect(cart.items.second.product).to be_a Product
    end
  end

  context "二、計算放到購物車的商品金額" do

    it "每個 CartItem 可以試算金額" do
      cart = Cart.new
      item1 = Product.create(name:"baseball",price: 100)
      item2 = Product.create(name:"cellphone",price: 5000)

      cart = Cart.new
      3.times { cart.add_item(item1.id) }
      4.times { cart.add_item(item2.id) }
      2.times { cart.add_item(item1.id) }
      
      expect(cart.items.first.price).to be 500
      expect(cart.items.second.price).to be 20000


    end

    it "可以試算購物車的總消費" do
      cart = Cart.new
      item1 = Product.create(name:"baseball",price: 100)
      item2 = Product.create(name:"cellphone",price: 5000)

      3.times {
        cart.add_item(item1.id)
        cart.add_item(item2.id)
      }
      expect(cart.total_price).to be 15300
    end

  end

  # context "三、提供折扣" do

  #   xit "提供優惠折扣" do
  #   end

  # end

  end

end