class Room

  attr_reader :name, :space, :entry_fee, :playlist, :guests_list

  def initialize(name, space, entry_fee, sales_register)
    @name = name
    @space = space
    @entry_fee = entry_fee
    @playlist = []
    @guests_list = []
    @sales_register = sales_register
  end

  def add_song(song)
      @playlist << song
  end

  def check_in(guest)
    if @space > @guests_list.count
      if @entry_fee < guest.wallet
        @guests_list << guest
        guest.pay_out(entry_fee)
        @sales_register.pay_in(entry_fee)
        @sales_register.record_sale(@name, guest, "entry fee", @entry_fee)
        return "Welcome #{guest.name}!"
      else
        return "#{guest.name}, you don't have enough money"
      end
    else
      return "Not enough room"
    end
  end

  def check_out(guest)
    @guests_list.delete(guest)
  end

end
