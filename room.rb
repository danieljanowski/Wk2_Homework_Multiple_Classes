class Room

  attr_reader :name, :space, :entry_fee, :playlist, :guests_list

  def initialize(name, space, entry_fee)
    @name = name
    @space = space
    @entry_fee = entry_fee
    @playlist = []
    @guests_list = []
  end

  def add_song(song)
      @playlist << song
  end

  def check_in(guest)
    if @space > @guests_list.count
      @guests_list << guest
      guest.pay_out(entry_fee)
    else
      return "Not enough room"
    end
  end

  def check_out(guest)
    @guests_list.delete(guest)
  end

end
