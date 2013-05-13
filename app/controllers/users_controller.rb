#encoding: utf-8
class UsersController < ApplicationController
  def new
    @user=User.new
  end
  def create
    @user=User.new(params[:user])
    if @user.save
      flash[:notice] = "Вы успешно зарегистрировались!"
      session[:id]=@user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user= User.find(params[:id])
  end
end
