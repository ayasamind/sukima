class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end
 
  def show
    @admin = Admin.find(params[:id])
  end
  
  def update
    @admin = Admin.find(params[:id])
    @admin.assign_attributes(params[:admin])
    if @admin.save
            redirect_to @admin, notice:"会員情報を更新しました。"
        else
            render "edit"
        end
    end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :about, :web, :address, :industry, :sns, :image])
  end
end