#encoding: utf-8
require "smsc_api"
VALID_PHONE_NUMBER_REGEX= /\A38( ||)[0-9]{3}( |)[0-9]{7}\z/

class SendSmsController < ApplicationController
  before_filter :signed_in_user
  before_filter :current_user
  
  def new
    
  end
  
  def create
    if VALID_PHONE_NUMBER_REGEX===params[:sms][:phone_number] && params[:sms][:message].length <= 240
      sms = SMSC.new()
      sms_request = [];
      #sms_request = sms.send_sms(params[:sms][:phone_number], params[:sms][:message],1)
      status = sms_request.size == 4 ? true : false
      @user.sent_smses.create(:sms_id => sms_request[0], :phone_number => params[:sms][:phone_number], :message => params[:sms][:message], :status => status)
      flash.now[:notice] = "Сообщение успешно отправлено в обработку"
      render :new
    else
      flash.now[:error] = "Ошибка в заполнении формы"
      render :new
    end
  end
  
  def index
    @smses = @user.sent_smses.all(:order => 'created_at DESC')
  end
  
  def destroy
    sms = SentSms.find(params[:id])
    @user.sent_smses.delete(sms)
    redirect_to user_send_sms_path(@user)
  end
  
  private
  
  def current_user
    @user = User.find(session[:id])
  end
  
end