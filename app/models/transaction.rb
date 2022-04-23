# frozen_string_literal: true

# Model to store the transactions
class Transaction < ApplicationRecord
  self.table_name = 'api_transactions'
end
