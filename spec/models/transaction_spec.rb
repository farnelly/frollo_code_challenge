# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'when initialised with factory' do
    it 'is valid with valid attributes' do
      expect(described_class.new).to be_valid
    end
  end

  describe 'after_save' do
    let!(:transaction) { build(:transaction) }
  
    it 'enqueues background job to categorise transaction' do
      expect(CategorisationProcessJob).to receive(:perform_async)
        .with(id: 1)

      transaction.save

      expect(transaction.category).to eq('Uncategorised')
    end
  end
end
