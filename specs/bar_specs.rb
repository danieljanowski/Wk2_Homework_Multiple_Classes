require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../bar'
require_relative '../guest'
require_relative '../room'
require_relative '../sales_register'

class BarTest < Minitest::Test

  def setup
    @sales_register = Sales_Register.new
    @room1 = Room.new("Rainbow Room", 5, 20, @sales_register)
    @bar1 = Bar.new("Karaoke", @room1, @sales_register)
    @guest1 = Guest.new("Daniel", @song1, 100)
  end

  def test_add_item_to_bar
    @bar1.add_item("Diet Coke", 10, 2.00)
    assert_equal(10, @bar1.stock["Diet Coke"][:quantity])
    #check if stock is updated for existing item
    @bar1.add_item("Diet Coke", 5)
    assert_equal(15, @bar1.stock["Diet Coke"][:quantity])
    #new item
    @bar1.add_item("Coke", 20, 1.80)
    assert_equal(20, @bar1.stock["Coke"][:quantity])
    assert_equal(["Diet Coke", "Coke"], @bar1.stock.keys)
  end

  def test_guest_buys_item
    @bar1.add_item("Diet Coke", 10, 2.00)
    @bar1.buy(@guest1, "Diet Coke")
    assert_equal(98, @guest1.wallet)
    assert_equal(2.00, @sales_register.total_cash)
    assert_equal(9, @bar1.stock["Diet Coke"][:quantity])
    assert_equal(2.00, @sales_register.records[@room1.name][:total])
  end

  def test_return_item_price_by_name
    @bar1.add_item("Diet Coke", 10, 2.00)
    result = @bar1.find_price("Diet Coke")
    assert_equal(2.00, result)
  end

end
