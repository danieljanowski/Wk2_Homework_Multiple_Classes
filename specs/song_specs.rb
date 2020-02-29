require ('minitest/autorun')
require ('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../song')

class SongTest < MiniTest::Test

  def setup
    @song1 = Song.new("Christmas Song")
  end

  def test_song_has_name
    assert_equal("Christmas Song", @song1.name)
  end

end
