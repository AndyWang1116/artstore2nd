class Order < ActiveRecord::Base
  belongs_to :user

  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one  :info,  class_name: "OrderInfo", dependent: :destroy

  # 當頁面同時送出form給兩個model時，也就是巢狀表單，則要在model內進行宣告。這裡是對model order宣告接受model orderinfo 的巢狀屬性
  accepts_nested_attributes_for :info

  before_create :generate_token

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|       # 這邊的items指的是model order_item 所以會有product_name price quantity等欄位可呼叫
      item = items.build                 # 新創一個order_item的object 叫做item
      item.product_name = cart_item.title   # 將目前cart_item的各種資訊都存進去item這個object
      item.quantity = 1
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price  # 呼叫cart內的total_price, 存進被呼叫的order本身的total欄位
    self.save  # 儲存進db
  end

  # 定義 generate_token這個method, 使用內建SecureRandoom.uuid 產生出特定的值 存進目前order本身的token欄位
  def generate_token
    self.token = SecureRandom.uuid
  end

  # 設定order付款完成的method
  def set_payment_with!(method)
    self.update_columns(payment_method: method)
  end

  #設定付款方式完成紀錄的method
  def pay!
    self.update_columns(is_paid: true)
  end
end
