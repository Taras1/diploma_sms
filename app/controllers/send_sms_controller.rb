#encoding: utf-8
require "smsc_api"
#VALID_PHONE_NUMBER_REGEX= /\A38( ||)[0-9]{3}( |)[0-9]{7}\z/

class SendSmsController < ApplicationController
  before_filter :signed_in_user
  before_filter :current_user
  
  def new
    @sms = @user.sent_smses.new
  end
  
  def create
    @sms = @user.sent_smses.new(:phone_number => params[:sms][:phone_number], :message => params[:sms][:message])
    if @sms.valid?
      sms = SMSC.new()
      sms_request = sms.send_sms(params[:sms][:phone_number], params[:sms][:message], 1)
      status = sms_request.size == 4 ? true : false
      @sms.sms_id = sms_request[0]
      @sms.status = status
      @sms.save
      if status
        flash.now[:notice] = "Сообщение успешно отправлено"
      else
        flash.now[:error] = "Сообщение не отправлено, код ошибки: #{sms_request[1]}"
      end
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
    sms = @user.sent_smses.find(params[:id])
    @user.sent_smses.destroy(sms)
    redirect_to user_send_sms_path(@user)
  end
  
  private
  
  def current_user
    @user = User.find(session[:id])
  end
  
end