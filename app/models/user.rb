class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def admin?
    is_admin    #  讀取 user資料庫裡 is_admin的欄位內容 (true / false)
  end
end
