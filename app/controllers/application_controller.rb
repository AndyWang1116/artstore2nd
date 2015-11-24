class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def admin_required
    if !current_user.admin?
      redirect_to "/"
    end
  end

  # 若要同時能讓controller和View 都能使用，就要加上helper_method的設定
  helper_method :current_cart

  # 如果 @current 不為空, 回傳@current_cart
  def current_cart
    @current_cart ||= find_cart  # 若這個值是空的話, 就去執行find_cart這個method
  end

  private

  def find_cart   # 定義 find_cart 這個method
    # 首先去找現在使用者的session有沒有cart_id這個值，這樣就可以找到現在這個使用者的購物車
    cart = Cart.find_by(id: session[:cart_id])  # 宣告 variable  cart, 在Cart model找id是 session裡的cart_id值傳回給cart

    # 如果找不到，就幫他創造一個購物車
    unless cart.present?     # 當cart沒有值的時候
      cart = Cart.create     # 對Cart創造一個有cart_id的值傳回給cart
    end

    # 再將cart的值 重新設定給使用者目前 session[:card_id]的值
    session[:cart_id] = cart.id   # 將cart.id值傳給session
    cart                          # 回傳cart的值 (return被省略掉)
  end
end
