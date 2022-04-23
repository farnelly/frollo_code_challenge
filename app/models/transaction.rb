# frozen_string_literal: true

# Model to store the transactions
class Transaction < ApplicationRecord
  self.table_name = 'api_transactions'

  after_create :categorise_process

  def categorise_process
    CategorisationProcessJob.perform_async(id)
  end
end
