# frozen_string_literal: true

require 'rails_helper'

describe CodeGenerator do
  describe '#code' do
    let(:ticket) { create(:ticket, code: nil) }

    it 'is expected to set code with alphanumeric string' do
      expect(ticket.code).to a_value
    end
  end
end
