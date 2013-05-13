#encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    if authenticate(params[:session][:email], params[:session][:password])
      sign_in
    else
      flash[:error] = "Неверный E-mail или пароль!"
      render :new
    end
  end

  def destroy
    session[:id]=nil
    redirect_to root_path
  end
  
  private
  
  def authenticate(email, password)
    @user = User.find_by_email(email)
    if @user && (Digest::SHA1.hexdigest(password) == @user.password)
      return true
    else 
      false
    end
  end
  
  def sign_in
    session[:id]=@user.id
    redirect_to user_path(session[:id])
  end
end
