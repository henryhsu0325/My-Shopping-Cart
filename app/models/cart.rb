class Cart
  attr_accessor :items

  def initialize
    @items = []
  end

  def add_item(product_id)
    find_item = items.find { |item| item.product_id == product_id}
    if find_item
      find_item.increment
    else
      @items << CartItem.new(product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def total_price
    items.reduce(0) { |sum, item| sum + item.price }
  end

end