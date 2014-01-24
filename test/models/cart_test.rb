require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

 	fixtures :products
  test "should add products to cart properly" do
	  cart = Cart.create

	  cart.add_product(products(:one).id).save!
	  assert_equal cart.line_items.size, 1

	  cart.add_product(products(:ruby).id).save!
	  assert_equal cart.line_items.size, 2

	  li = cart.add_product(products(:ruby).id)
	  li.save!
	  assert_equal li.quantity, 2, 'should increase line items quantity to 2'
	  assert_equal cart.line_items.size, 2
	end
end
