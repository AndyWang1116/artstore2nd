class CartItemsController < ApplicationController
  def destroy
    @cart  = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])  # 從現有購物車找到相對應的item id 存進@item
    @product = @item.product                # 將@item刪掉前, 先存一個臨時的@product
    @item.destroy

    flash[:warning] = "成功將 #{@product.title} 從購物車刪除!"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])   # 對curren_cart搜尋product_id為目前網址輸入的數字的cart_item,傳給@item

    @item.update(item_params)  # 遇到update需要使用strong_parameter概念,讓指定欄位通過

    redirect_to carts_path
  end

  private

    # 使用item_param這個fuction時，對cart_item db做更改只有quantity這欄位可通過
    def item_params
      params.require(:cart_item).permit(:quantity)
    end

end
