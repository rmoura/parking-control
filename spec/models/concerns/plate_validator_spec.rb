# frozen_string_literal: true

require 'rails_helper'

describe PlateValidator do
  describe '#valid?' do
    context 'when valid plate' do
      let(:ticket) { build(:ticket) }
      it { expect(described_class.valid?(ticket.plate)).to be_truthy }
    end

    context 'when invalid plate' do
      it { expect(described_class.valid?('EIW-99')).to be_falsey }
    end
  end

  describe '#validate' do
    context 'when valid plate' do
      let(:ticket) { build(:ticket) }

      it { expect(ticket.valid?).to be_truthy }

      describe '#errors' do
        it { expect(ticket.errors).to be_empty }
      end
    end

    context 'when invalid plate' do
      let(:ticket) { build(:ticket, plate: 'AB-1234') }
      before { ticket.valid? }

      describe '#errors' do
        it do
          expect(ticket.errors.messages).to include(
            plate: [
              a_string_matching('AB-1234 is invalid! Expected format: XYZ-1234')
            ]
          )
        end
      end
    end
  end
end
