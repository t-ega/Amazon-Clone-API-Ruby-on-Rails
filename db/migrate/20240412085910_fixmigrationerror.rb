class Fixmigrationerror < ActiveRecord::Migration[7.1]
  def change
    rename_column :authors, :user_id, :user
  end
end
