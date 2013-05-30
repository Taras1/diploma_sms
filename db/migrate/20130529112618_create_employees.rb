class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.references :user
      t.string :phone_number

      t.timestamps
    end
    add_index :employees, :user_id
  end
end
