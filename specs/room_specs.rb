require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../room'
require_relative '../song'
require_relative '../guest'

class RoomTest < Minitest::Test

  def setup
    @room1 = Room.new("Rainbow Room", 2, 20)
    @song1 = Song.new("Christmas Song")
    @guest1 = Guest.new("Daniel", "Christmas Song", 100)
    @guest2 = Guest.new("Ollie", "Alone", 50)
    @guest3 = Guest.new("Naomi", "King of my Heart", 70)
    @guest4 = Guest.new("Samuel", "Another favorite song", 10)
  end

  def test_room_has_name_space_entry_fee_and_playlist
    assert_equal("Rainbow Room", @room1.name)
    assert_equal(2, @room1.space)
    assert_equal(20, @room1.entry_fee)
    assert_equal(0, @room1.playlist.count)
  end

  def test_add_song_to_rooms_playlist
    @room1.add_song(@song1.name)
    assert_equal(["Christmas Song"], @room1.playlist)
  end

  def test_check_in
    @room1.check_in(@guest1)
    assert_equal(1, @room1.guests_list.length)
    assert_equal(80, @guest1.wallet)
  end

  def test_check_in_not_enough_room
    @room1.check_in(@guest1)
    assert_equal(80, @guest1.wallet)
    assert_equal(1, @room1.guests_list.length)

    @room1.check_in(@guest2)
    assert_equal(30, @guest2.wallet)
    assert_equal(2, @room1.guests_list.length)

    result = @room1.check_in(@guest3)
    assert_equal("Not enough room", result)
    assert_equal(70, @guest3.wallet)
    assert_equal(2, @room1.guests_list.length)
  end

  def test_check_in_not_enough_money
    result = @room1.check_in(@guest4)
    assert_equal("Samuel, you don't have enough money", result)
    assert_equal(0, @room1.guests_list.length)
  end

  def test_check_out
    @room1.check_in(@guest1)
    assert_equal(1, @room1.guests_list.length)
    @room1.check_out(@guest1)
    assert_equal(0, @room1.guests_list.length)
  end

end
