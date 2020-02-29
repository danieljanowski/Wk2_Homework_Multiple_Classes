require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../guest'
require_relative '../song'

class GuestTest < Minitest::Test

  def setup
    @song1 = Song.new("Christmas Song")
    @song2 = Song.new("Some Other Song")
    @guest1 = Guest.new("Daniel", @song1, 100)
    @playlist = [@song1, @song2]
  end

  def test_guest_has_name_favorite_song_and_wallet
    assert_equal("Daniel", @guest1.name)
    assert_equal("Christmas Song", @guest1.favourite_song.name)
    assert_equal(100, @guest1.wallet)
  end

  def test_guest_is_able_to_pay
    @guest1.pay_out(10)
    assert_equal(90, @guest1.wallet)
  end

  def test_guest_likes_the_song
    assert_equal("Daniel: Whoo! I like Christmas Song!", @guest1.likes_song?(@playlist))
  end

end
