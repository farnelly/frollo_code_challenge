# frozen_string_literal: true

require 'rails_helper'

# Tests for transactions
RSpec.describe Api::TransactionsController, type: :request do
  describe '#index' do
    subject(:list_transactions) do
      get '/api/transactions'
    end

    let(:transaction1) do
      create(:transaction, posted_date: '2022-01-01', currency: 'USD')
    end
    let(:transaction2) { create(:transaction) }
    let(:transaction_list) { [transaction1, transaction2] }

    let(:list_transactions_response) do
      [
        {
          id: 1,
          posted_date: '2022-01-01',
          currency: 'USD',
          amount: 100.00,
          description: 'This is a test',
          type: 'PAYMENT',
          category: 'UNCATEGORISED'
        },
        {
          id: 2,
          posted_date: '2021-01-01',
          currency: 'AUD',
          amount: 100.00,
          description: 'This is a test',
          type: 'PAYMENT',
          category: 'UNCATEGORISED'
        }
      ].as_json
    end

    context 'when the request is made but no transactions exist' do
      it 'returns empty list of transactions' do
        list_transactions
        expect(response.parsed_body).to eq([])
      end

      it 'returns successful HTTP status code' do
        list_transactions
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the request is made to list transactions' do
      before { transaction_list }

      it 'returns lists of transactions' do
        list_transactions
        expect(response.parsed_body).to eq(list_transactions_response)
      end

      it 'returns successful HTTP status code' do
        list_transactions
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    subject(:show_transactions) do
      get "/api/transactions/#{transaction_id}"
    end

    let(:transaction_id) { 1234 }
    let(:transaction) { create(:transaction) }

    let(:transactions_response) do
      {
        id: 1,
        posted_date: '2021-01-01',
        currency: 'AUD',
        amount: 100.00,
        description: 'This is a test',
        type: 'PAYMENT',
        category: 'UNCATEGORISED'
      }.as_json
    end

    context 'when the transaction does not exist' do
      it 'returns ActiveRecord::RecordNotFound error' do
        expect { show_transactions }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the request is made to fetch transaction' do
      let(:transaction_id) { transaction.id }

      it 'returns transaction' do
        show_transactions
        expect(response.parsed_body).to eq(transactions_response)
      end

      it 'returns successful HTTP status code' do
        show_transactions
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#create' do
    subject(:create_transaction) do
      post '/api/transactions/', params: create_params
    end

    let(:create_params) do
      {
        posted_date: '2021-01-01',
        currency: 'AUD',
        amount: 100.0,
        description: 'This is a test',
        type: 'PAYMENT'
      }
    end

    context 'when the request params is invalid' do
      let(:create_params) do
        { currency: 'NPR' }
      end

      let(:error_message) do
        {
          'field' => '#/currency',
          'message' => 'value "NPR" did not match one of the following values: AUD, USD, GPD'
        }
      end

      it 'returns error' do
        create_transaction
        expect(response.parsed_body.dig('error', 'errors')).to include(error_message)
      end

      it 'returns unsuccessful HTTP status code' do
        create_transaction
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the request is valid' do
      it 'returns transaction' do
        expect { create_transaction }.to change { Transaction.count }.by(1)
      end

      it 'returns successful HTTP status code' do
        create_transaction
        expect(response).to have_http_status(:success)
      end
    end
  end
end
