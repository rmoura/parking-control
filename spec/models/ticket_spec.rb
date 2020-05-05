# frozen_string_literal: true

require 'rails_helper'

describe Ticket do
  let(:ticket) { build(:ticket) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:plate) }

    it { expect(ticket).to validate_uniqueness_of(:code).case_insensitive }

    it { is_expected.to define_enum_for(:status).with_values(%i[pending paid]) }

    it 'is expected to validate that :plate is valid' do
      expect(ticket.plate).to a_value
    end

    describe '#validates_with PlateValidator' do
      let(:ticket) { build(:ticket, plate: 'AB-1234') }

      it 'is expected to validate :plate with PlateValidator' do
        expect(described_class.validators).to include(PlateValidator)
      end

      it 'is expected to validate :plate mask' do
        l = -> {
          ticket.valid?
          ticket.errors.messages
        }

        expect(l.call).to include(
          plate: [a_string_matching('is invalid! Expected format')]
        )
      end
    end

    describe '#code' do
      context 'on create Ticket' do
        let(:ticket) { build(:ticket, code: nil) }

        it 'is expected to set code with alphanumeric string' do
          expect(ticket.code).to be_nil
          expect(ticket.save && ticket.code).to a_value
        end
      end
    end

    describe '#paid?' do
      context 'when pending payment' do
        let(:ticket) { create(:ticket) }
        it { expect(ticket.paid?).to be_falsey }
      end

      context 'when successful payment' do
        let(:ticket) { create(:ticket, status: :paid) }
        it { expect(ticket.paid?).to be_truthy }
      end
    end
  end
end
