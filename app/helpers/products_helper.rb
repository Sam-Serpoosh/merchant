module ProductsHelper
  def print_price(price)
    number_to_currency price
  end

  def print_stock(stock, requested = 1)
    if stock >= requested
      "<span class='in_stock'>In Stock (#{stock})</span>".html_safe
    elsif stock < requested && stock != 0
      "<span class='low_stock'>Insufficient Stock</span>".html_safe
    elsif stock
      "<span class='out_stock'>Out of Stock</span>".html_safe
    end
  end
end
