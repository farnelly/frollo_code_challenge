# frozen_string_literal: true

# Model to store the transactions
class Transaction < ApplicationRecord
  self.table_name = 'api_transactions'

  validates :currency,
            inclusion: { in: %w[AUD USD GPD],
                         message: 'value %<value>s did not match one of the following values:
                                   AUD, USD, GPD' },
            allow_nil: true
  validates :transaction_type,
            inclusion: { in: %w[TRANSFER_OUTGOING TRANSFER_INCOMING PAYMENT OTHER] },
            allow_nil: true
  validates :description, length: { maximum: 300 }

  after_create :categorise_process

  def categorise_process
    CategorisationProcessJob.perform_now(id)
  end
end
