class RenameColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :authors, :user, :user_id
  end
end
