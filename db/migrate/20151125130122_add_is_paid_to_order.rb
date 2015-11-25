class AddIsPaidToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :is_paid, :boolean, default: false  # 加入欄位到db orders ,欄位叫is_paid, 是boolean, 預設值為false(未付款)
  end
end
