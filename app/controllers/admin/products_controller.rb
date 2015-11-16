class Admin::ProductsController < ApplicationController

layout "admin"

before_action :authenticate_user! # 使用者必須要登入才能存取後台
before_action :admin_required     # 使用者必須是admin權限 (新增is_admin欄位到user.rb且預設值為false)

def index
  @products = Product.all
end

def new
  @product = Product.new
  @photo = @product.build_photo
end

def edit
  @product = Product.find(params[:id])
  @photo = @product.photo
end

def update
  @product = Product.find(params[:id])

  if @product.update
    reditect_to admin_products_path
  else
    render :new
  end
end

def create
  @product = Product.new(product_params)

  if @product.save
    redirect_to admin_products_path
  else
    render :new
  end
end


private

def product_params
  params.require(:product).permit(:title, :description, :quantity, :price, photo_attributes: [:image, :id])
end


end
