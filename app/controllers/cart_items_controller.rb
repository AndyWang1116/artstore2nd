class CartItemsController < ApplicationController
  def destroy
    @cart  = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])  # 從現有購物車找到相對應的item id 存進@item
    @product = @item.product                # 將@item刪掉前, 先存一個臨時的@product
    @item.destroy

    flash[:warning] = "成功將 #{@product.title} 從購物車刪除!"
    redirect_to :back
  end

end
