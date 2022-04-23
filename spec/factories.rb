# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    posted_date { '2021-01-01' }
    currency { 'AUD' }
    amount { 100.00 }
    description { 'This is a test' }
    transaction_type { 'PAYMENT' }
    category { 'Uncategorised' }
  end
end
