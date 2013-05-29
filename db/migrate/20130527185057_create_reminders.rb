class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.text :message
      t.string :phone_number
      t.references :user
      t.string :time_to_send
      t.integer :sms_id
      t.boolean :status

      t.timestamps
    end
    add_index :reminders, :user_id
  end
end
