class AddCategoryIdToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_column :expenses, :category_id, :integer
    add_column :expenses, :type_id, :integer
  end
end
