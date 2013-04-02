require 'active_support/core_ext/string'

module ProductPresenter
  def print_stock requested=1
    if self.stock >= requested
      "<span class='in_stock'>In Stock (#{stock})</span>".html_safe
    elsif self.stock < requested && stock != 0
      "<span class='low_stock'>Insufficient Stock</span>".html_safe
    else
      "<span class='out_stock'>Out of Stock</span>".html_safe
    end
  end
end
