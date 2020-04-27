# frozen_string_literal: true

require 'rails_helper'

describe Payment do
  describe 'validations' do
    it { is_expected.to validate_numericality_of(:cost_cents) }

    it { is_expected.to monetize(:cost) }
    it { is_expected.to monetize(:discount) }
    it { is_expected.to monetize(:total) }
  end

  describe 'associations' do
    it { should belong_to(:ticket) }
  end
end
