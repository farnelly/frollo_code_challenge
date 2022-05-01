# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'when initialised with factory' do
    it 'is valid with valid attributes' do
      expect(described_class.new).to be_valid
    end
  end

  describe 'currency' do
    let!(:transaction) { build(:transaction) }

    it 'is valid' do
      transaction.currency = 'AUD'
      expect(transaction).to be_valid
    end

    it 'is not valid' do
      transaction.currency = 'JPY'
      expect(transaction).to_not be_valid
    end
  end

  describe 'transaction_type' do
    let!(:transaction) { build(:transaction) }

    it 'is valid' do
      transaction.transaction_type = 'TRANSFER_INCOMING'
      expect(transaction).to be_valid
    end

    it 'is not valid' do
      transaction.transaction_type = 'TRANSFER'
      expect(transaction).to_not be_valid
    end
  end

  describe 'description' do
    let!(:transaction) { build(:transaction) }

    it 'is valid' do
      transaction.description = 'This is a test'
      expect(transaction).to be_valid
    end

    it 'is not valid' do
      transaction.description = 'a' * 301
      expect(transaction).to_not be_valid
    end
  end

  describe 'after_save' do
    let!(:transaction) { build(:transaction) }

    it 'enqueues background job to categorise transaction' do
      expect(CategorisationProcessJob).to receive(:perform_now)
        .with(1)

      transaction.save

      expect(transaction.reload.category).to eq('Uncategorised')
    end
  end
end
