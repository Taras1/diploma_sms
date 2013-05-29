#encoding: utf-8
require "smsc_api"
class RemindersController < ApplicationController
  before_filter :signed_in_user
  before_filter :current_user
  helper_method :check_to_add_link
  
  def index
    @reminders = @user.reminders.all(:order => 'time_to_send')
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = @user.reminders.create(message:params[:reminder][:message], phone_number:params[:reminder][:phone_number], time_to_send:params[:reminder][:time_to_send])
    if @reminder.save
      time = @reminder.time_to_send[8..9] + @reminder.time_to_send[5..6] + @reminder.time_to_send[2..3] + @reminder.time_to_send[11..12] + @reminder.time_to_send[14..16]
      sms = SMSC.new()
      sms_request = sms.send_sms(@reminder.phone_number, @reminder.message, 1, time)
      @reminder.sms_id = sms_request[0]
      status = sms_request.size == 4 ? true : false
      @reminder.status = status
      @reminder.save
      redirect_to user_reminders_path(:user_id => session[:id])
    else
      flash.now[:error] = "Ошибка заполнения формы!"
      render :new
    end
  end

  def destroy
    reminder = Reminder.find(params[:id])
    @user.reminders.delete(reminder)
    redirect_to user_reminders_path(:user_id => session[:id])
  end
  
  def check_to_add_link(time_str, status)
     time_str = time_str.to_s
     dd = time_str[8..9]
     mm = time_str[5..6]
     yyyy = time_str[0..3]
     hh = time_str[11..12]
     min = time_str[14..15]
     time = Time.new(yyyy, mm, dd, hh, min)
     time_now = Time.now
     condition = time_now > time
     !status || condition
  end
  
  private
  
  def current_user
    @user = User.find(session[:id])
  end
  
end
