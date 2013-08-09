#encoding: utf-8
class SentSms < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message, :phone_number, :sms_id, :status
  
  VALID_PHONE_NUMBER_REGEX= /\A38( ||)[0-9]{3}( |)[0-9]{7}\z/
  
  validates :message, length: {in: 1..240, message:"Сообщение должно содержать от 1 до 240 символов"}
  validates :phone_number, format: {with:VALID_PHONE_NUMBER_REGEX, message:"Неверно введен номер телефона"}
  
  before_save do |sms|
    sms.phone_number = sms.phone_number.delete " "
  end
  
end
