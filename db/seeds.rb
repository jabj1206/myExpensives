# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Category.create(name: "Restaurants")
Category.create(name: "Grocery")
Category.create(name: "Car")
Category.create(name: "Services")
Category.create(name: "Home")
Category.create(name: "Education")
Category.create(name: "Fun")
Category.create(name: "Travel")
Type.create(name: "Purchase")
Type.create(name: "Withdrawal")
Type.create(name: "Transfer")
Type.create(name: "Payment")

300.times do
    Expense.create([{
      concept: Faker::Commerce.product_name,
      amount: rand(1000..2000000),
      date: Faker::Date.between(6.month.ago, Date.today),
      category_id: rand(1..8),
      type_id: rand(1..4)
      }])
  end