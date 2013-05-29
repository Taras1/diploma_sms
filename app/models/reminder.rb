#encoding: utf-8
require "smsc_api"
class Reminder < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message, :phone_number, :sms_id, :status, :time_to_send
  
  VALID_TIME_REGEX = /\A20((1[3-9])|(2[0-9]))-((0[1-9])|(1[0-2]))-[0-3][0-9] (((|[0-1])[0-9])|(2[0-3])):[0-5][0-9]\z/
  VALID_PHONE_NUMBER_REGEX = /\A38( ||)[0-9]{3}( |)[0-9]{7}\z/
  
  validates :message, length: {in: 1..240, message:"Сообщение должно содержать от 1 до 240 символов"}
  #validates :phone_number, format: {with: VALID_PHONE_NUMBER_REGEX, message: "Неверно введен номер телефона"}
  validates :time_to_send, format: {with: VALID_TIME_REGEX, message: "Неверно введена дата"}

  #after_validation do |rmd|
      
  #end

end