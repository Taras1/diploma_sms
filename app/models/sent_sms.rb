class SentSms < ActiveRecord::Base
  belongs_to :user
  attr_accessible :message, :phone_number, :sms_id, :status
end
