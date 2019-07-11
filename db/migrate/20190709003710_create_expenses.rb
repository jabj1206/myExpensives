class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :type
      t.string :concept
      t.string :category
      t.integer :amount
      t.date :date

      t.timestamps
    end
  end
end
