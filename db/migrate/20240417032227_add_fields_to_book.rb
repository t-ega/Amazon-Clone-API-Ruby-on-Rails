class AddFieldsToBook < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :price, :integer
    add_column :books, :desc, :string
  end
end
