# frozen_string_literal: true

require 'rails_helper'

describe CategorisationProcessJob do
  describe '#perform' do
    subject(:categorise_transaction) { described_class.new.perform(params) }

    let!(:transaction) { create(:transaction) }
    let(:params) { transaction.id }

    it 'sends request to users app to reject time report' do
      expect(Categorisation).to receive(:categorise)
        .with(transaction.description,
              transaction.amount,
              transaction.transaction_type)

      categorise_transaction

      expect(transaction.category).to eq('Uncategorised')
    end
  end
end
