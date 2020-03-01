class Sales_Register

  attr_accessor :total_cash, :records

  def initialize
    @total_cash = 0.0
    @records = {}
  end

  def pay_in(amount)
    @total_cash += amount
  end

  def record_sale(room, guest, item, price)
    if @records.include?(room)
      @records[room][:total] += price
    else
      @records[room] = {:total => price}
    end
  end




end
