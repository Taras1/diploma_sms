class RenameHashOfPasswordToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :hash_of_password, :password
  end
end
