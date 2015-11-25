class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)  # 對允許的params產生一個新的order叫做@order

    if @order.save
      @order.build_item_cache_from_cart(current_cart)   # @order呼叫 order.rb裡定義的function, 產生cache(日後產品可能會被刪掉)
      @order.calculate_total!(current_cart)             # 將目前購物車總金額的值存進訂單的金額欄位(total)
      redirect_to order_path(@order)
    else
      render "carts/checkout"   # 跨controller時(這邊是orders,要跨到carts), 且複用template , 在同一controller裡則是render :new
    end
  end



  private

  def order_params
    # 宣告巢狀時需要這樣子寫: permit裡面宣告info_attributes: [ ]
    # .permit會呼叫 model屬性，在這裡info_attributes Rails會認出來model order有定義info是OrderInfo ,而其中這四項欄位可以通過
    params.require(:order).permit(info_attributes: [:billing_name,
                                                    :billing_address,
                                                    :shipping_name,
                                                    :shipping_address] )
  end
end
