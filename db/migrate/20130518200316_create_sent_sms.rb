class CreateSentSms < ActiveRecord::Migration
  def change
    create_table :sent_sms do |t|
      t.integer :sms_id
      t.string :phone_number
      t.text :message
      t.boolean :status
      t.references :users

      t.timestamps
    end
    add_index :sent_sms, :users_id
  end
end
