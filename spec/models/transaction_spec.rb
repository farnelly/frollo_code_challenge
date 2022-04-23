# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'when initialised with factory' do
    it 'is valid with valid attributes' do
      expect(described_class.new).to be_valid
    end
  end
end
