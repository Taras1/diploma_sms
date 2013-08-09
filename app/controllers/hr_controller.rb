#ecoding: utf-8
require "smsc_api"

class HrController < ApplicationController
  before_filter :signed_in_user
  before_filter :current_user
  
  def index
    @employees = @user.employees.all(:order => "last_name")
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = @user.employees.create(first_name: params[:employee][:first_name], last_name: params[:employee][:last_name], phone_number:params[:employee][:phone_number])
    if @employee.save
      flash[:notice] = "Работник успешно добавлен"
      redirect_to user_hr_index_path(:user_id => session[:id])
    else
      flash.now[:error] = "Ошибка заполнения формы"  
      render :new
    end
  end

  def destroy
    employee = @user.employees.find(params[:id])
    @user.employees.destroy(employee)
    redirect_to user_hr_index_url(:user_id => session[:id])
  end

  def send_sms
    sms = SMSC.new()
    employee = @user.employees.find(params[:employee_id])
    if employee and (params[:info][:message].size <= 240)
      sms_request = sms.send_sms(employee.phone_number, params[:info][:message], 1)
      status = sms_request.size == 4 ? true : false
      @user.sent_smses.create(:sms_id => sms_request[0], :phone_number => "#{employee.last_name} #{employee.first_name}", :message => params[:info][:message], :status => status)
      flash[:notice]  = "Сообщение успешно отправлено в обработку" if status
      flash[:error]   = "Ошибка отправки сообщения"                unless status
      redirect_to user_hr_index_url(:user_id => session[:id])
    else
      flash[:error] = "Ошибка отправки сообщения"
      redirect_to user_hr_index_url(:user_id => session[:id])
    end
  end

  def send_sms_for_all
    sms = SMSC.new()
    employees = @user.employees
    if employees
      phones = []
      employees.each do |empl|
        phones<<empl.phone_number
      end
      phones = phones.join(", ")
      sms_request = sms.send_sms(phones, params[:broadcast][:message], 1)
      status = sms_request.size == 4 ? true : false
      @user.sent_smses.create(:sms_id => sms_request[0], :phone_number => "Broadcast\t#{sms_request.size==4 ? sms_request[1] : 0}\tsms", :message => params[:broadcast][:message], :status => status)
      flash[:notice]  = "Сообщение успешно отправлено в обработку"  if status
      flash[:error]   = "Ошибка отправления"                        unless status
    end
    redirect_to user_hr_index_url(:user_id => session[:id])
  end
  
  private
  
  def current_user
    @user = User.find(session[:id])
  end
  
end
