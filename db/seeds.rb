# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Transaction.create(
  posted_date: '2021-01-01',
  currency: 'AUD',
  amount: 100.00,
  description: 'This is a test',
  transaction_type: 'PAYMENT',
  category: 'Uncategorised'
)

Transaction.create(
  posted_date: '2021-01-01',
  currency: 'USD',
  amount: 200.00,
  description: 'This is a test',
  transaction_type: 'PAYMENT',
  category: 'Uncategorised'
)
