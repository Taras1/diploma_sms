class SentSms < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message, :phone_number, :sms_id, :status
  
  before_save do |sms|
    sms.phone_number = sms.phone_number.delete " "
  end
  
end
