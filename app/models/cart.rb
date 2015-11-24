class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product # 讓Cart呼叫 cart_items時可以簡稱為 items

  def add_product_to_cart(product)
    items << product                # 將product的標籤條碼"貼到", "塞進"(<<)購物車格子(cart_items,在上面has_many已可將其叫做items)
  end                               # 在Rails裡, 如果是array又有db的關係 rails會自動將內容插進去並且儲存
end
