class ReanmeColumnUsersIdInSendSms < ActiveRecord::Migration
  
  def change
    rename_column :sent_sms, :users_id, :user_id
  end

end
