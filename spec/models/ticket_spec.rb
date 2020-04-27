# frozen_string_literal: true

require 'rails_helper'

describe Ticket do
  describe 'validations' do
    let(:ticket) { build(:ticket) }

    it { is_expected.to validate_presence_of(:plate) }
    it { is_expected.to validate_presence_of(:code) }

    it { expect(ticket).to validate_uniqueness_of(:plate).case_insensitive }
    it { expect(ticket).to validate_uniqueness_of(:code).case_insensitive }
  end

  describe 'associations' do
    it { should have_one(:payment) }
  end
end
