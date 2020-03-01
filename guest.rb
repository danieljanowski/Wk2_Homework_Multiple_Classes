class Guest

  attr_reader :name, :favourite_song, :wallet
  attr_writer :wallet

  def initialize(name, favourite_song, wallet)
    @name = name
    @favourite_song = favourite_song
    @wallet = wallet
  end

  def pay_out(amount)
    @wallet -= amount
  end

  def likes_song?(playlist)
    return "#{@name}: Whoo! I like #{favourite_song.name}!" if playlist.find{|song| song == favourite_song}.name
  end
end
