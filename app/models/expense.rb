# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  concept     :string
#  amount      :decimal(, )
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  type_id     :integer
#

class Expense < ApplicationRecord
    validates :concept, :amount, :date, presence: true
    validates :amount, numericality: true
    belongs_to :category
    belongs_to :type

end
