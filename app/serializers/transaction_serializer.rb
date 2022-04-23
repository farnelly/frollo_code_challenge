# frozen_string_literal: true

# Serialise transactions API
class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :posted_date, :currency, :amount,
             :description, :category, :type

  def type
    object.transaction_type
  end
end
