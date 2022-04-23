class CategorisationProcessJob
  include Sidekiq::Job

  def perform(params)
    transaction = Transaction.find(params['id'])

    reutrn unless transaction

    category = Categorisation.categorise(transaction.description,
                                         transaction.amount,
                                         transaction.transaction_type)
    
    transaction.update(category: category)
  end
end
