class RenamePassordToHashOfPasswordInUsers < ActiveRecord::Migration
  def change
      rename_column :users, :passord, :hash_of_password
  end
end
