# frozen_string_literal: true

module Api
  # Transactions controller to list, get and create
  class TransactionsController < BaseController
    before_action :set_transaction, only: [:show]
    before_action :validate_schema, only: [:create]

    def index
      @transactions = Transaction.all

      render json: @transactions
    end

    # GET /api/transactions/1
    def show
      render json: @transaction
    end

    # POST /api/transactions
    def create
      @transaction = Transaction.new(transaction_params)

      if @transaction.save
        render json: @transaction, status: :created
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end

    private

    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_params
      permitted_params = params.permit(:posted_date, :currency, :amount, :description, :type)
      permitted_params[:transaction_type] = permitted_params.delete :type
      permitted_params
    end
  end
end
