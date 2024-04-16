class AddUniqueConstraintToAuthor < ActiveRecord::Migration[7.1]
  def change
    remove_index :authors, :user_id
    add_index :authors, :user_id, unique: true
  end
end
