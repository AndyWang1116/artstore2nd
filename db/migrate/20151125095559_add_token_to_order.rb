class AddTokenToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :token, :string
    add_index :orders, :token # 跟db說token這欄位要打上index, db會根據token欄位建立索引表 -> 加快讀取速度 優先
  end
end
