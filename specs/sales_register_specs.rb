require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../bar'
require_relative '../guest'
require_relative '../room'
require_relative '../sales_register'

class SalesRegisterTest < Minitest::Test

  def setup
    @sales_register = Sales_Register.new
    @room1 = Room.new("Rainbow Room", 2, 20.0, @sales_register)
    @room2 = Room.new("Yellow Room", 5, 30.0, @sales_register)
    @guest1 = Guest.new("Daniel", @song1, 100)
    @bar1 = Bar.new("Karaoke", @room1, @sales_register)
    @bar1.add_item("Coke", 20, 1.80)
  end

  def test_possible_to_update_total_cash
    @sales_register.pay_in(20)
    assert_equal(20, @sales_register.total_cash)
  end

  def test_possible_to_record_by_room_guest_and_item_paid_for
    @bar1.add_item("Diet Coke", 10, 2.00)
    @bar1.add_item("Coke", 20, 1.80)

    @sales_register.record_sale(@room1.name, @guest1, "entry fee", @room1.entry_fee)
    @sales_register.record_sale(@room1.name, @guest1, "Diet Coke", @bar1.find_price("Diet Coke"))
    assert_equal(22.00, @sales_register.records[@room1.name][:total])
    @sales_register.record_sale(@room2.name, @guest1, "entry fee", @room2.entry_fee)
    @sales_register.record_sale(@room2.name, @guest1, "Coke", @bar1.find_price("Coke"))
    assert_equal(31.80, @sales_register.records[@room2.name][:total])
  end

end
