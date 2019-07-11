class ChangeDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :expenses, :amount, :decimal
  end
end
