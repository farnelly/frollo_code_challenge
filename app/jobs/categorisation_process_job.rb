# frozen_string_literal: true

# Categorise transaction background job
class CategorisationProcessJob < ApplicationJob
  queue_as :default

  def perform(transaction_id)
    transaction = Transaction.find(transaction_id)

    reutrn unless transaction

    category = Categorisation.categorise(transaction.description,
                                         transaction.amount,
                                         transaction.transaction_type)

    transaction.update(category: category)
  end
end
