#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def signed_in_user
    if session[:id] == nil
      flash[:error]= "Вы должны зайти на сайт используя свой E-mail и пароль!"
      redirect_to signin_path
    end
  end
end
