class Categorisation
    # Returns a transaction category key from a given description, amount and transaction type.
    # This is simply to illustrate the concept of transaction categorisation.
    # The categories this method will return are:
    # - TRANSFER: indicates the transaction was a transfer
    # - TAKEAWAY: indicates the transaction was used to buy takeaway food
    # - GROCERIES: indicates the transaction was used at a supermarket
    # - PETROL: indicates the transaction was use to buy petrol
    # - UNCATEGORISED: indicates the transaction could not be categorised
    def self.categorise(description, amount, transaction_type)
        # TRANSFER category matching
        return 'TRANSFER' if transaction_type&.match(/transfer_incoming|transfer_outgoing/i)

        # TAKEAWAY category matching
        return 'TAKEAWAY' if description&.match(/.*(uber eats|deliveroo|menulog).*/i)

        # GROCERIES category matching
        return 'GROCERIES' if description&.match(/.*woolworths.*/i) && amount&.to_i&.abs < 50

        # PETROL category matching
        return 'PETROL' if description&.match(/.*woolworths.*/i) && amount&.to_i&.abs >= 50

        return 'UNCATEGORISED'
    end
end
