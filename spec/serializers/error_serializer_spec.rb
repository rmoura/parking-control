# frozen_string_literal: true

require 'rails_helper'

describe ErrorSerializer do
  let(:record) { build(:ticket, plate: 'AB-1234') }
  before { record.valid? }

  describe '#serialize' do
    it do
      expect(ErrorSerializer.new(record).serialize).to include(
        'plate AB-1234 is invalid! Expected format: XYZ-1234'
      )
    end
  end
end
