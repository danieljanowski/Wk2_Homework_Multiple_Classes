class Bar

  attr_reader :name, :stock, :sales_register

  def initialize(name, room, sales_register)
    @name = name
    @stock = Hash.new
    @sales_register = sales_register
    @room = room
  end

  def add_item(item_name, item_quantity, item_price = 0)
    if @stock.include?(item_name)   #increase current stock in hash if item exists
      @stock[item_name][:quantity] += item_quantity
    else                            #add new item go hash if it doesn't
      @stock[item_name] =
      {
        :price => item_price,
        :quantity => item_quantity
      }
    end
  end

  def buy(guest, item)
    if guest.wallet >= @stock[item][:price] && @stock[item][:quantity] > 0
      guest.pay_out(@stock[item][:price])
      sales_register.pay_in(@stock[item][:price])
      sales_register.record_sale(@room.name, guest, item, find_price(item))
      @stock[item][:quantity] -= 1
    end
  end

  def find_price(item)
    return @stock[item][:price]
  end

end
