require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../bar'

class BarTest < Minitest::Test

  def setup

  end

  def test_add_item_to_bar
    @bar1.add_item("Diet Coke", 2, 10)
    # assert_equal()
  end

end
