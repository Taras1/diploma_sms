#encoding: utf-8
class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
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
      flash.now[:error] = "Некорректные данные!"
      render :new
    end
  end
  def show
    @user= User.find(session[:id])
  end
end
