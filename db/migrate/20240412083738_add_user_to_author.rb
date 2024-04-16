class AddUserToAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :user, :integer
    add_index :authors, :user
  end
end
