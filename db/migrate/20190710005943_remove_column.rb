class RemoveColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :expenses, :type_p
    remove_column :expenses, :category
  end
end
