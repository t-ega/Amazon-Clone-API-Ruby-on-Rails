class AddDescriptionToAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :about, :string
  end
end
