# frozen_string_literal: true

require 'rails_helper'

describe Tickets::Filters do
  let(:klass) do
    Class.new do
      attr_accessor :params

      include Tickets::Filters

      def initialize
        @params = {}
      end
    end.new
  end

  subject { klass.instance_variable_set(:@ticket, ticket); klass }

  describe '#reserve_already_deallocated?' do
    context 'when reserve already deallocated' do
      let(:ticket) { create(:ticket) }

      it do
        expect {
          subject.reserve_already_deallocated?
        }.to raise_error Tickets::Error::ReserveAlreadyDeallocated
      end
    end

    context 'when reserve allocated' do
      let(:ticket) { create(:ticket, leave_date: nil) }

      it { expect(subject.reserve_already_deallocated?).to be_nil }
    end
  end

  describe '#pending_payment?' do
    context 'when pending payment' do
      let(:ticket) { create(:ticket, status: :pending) }

      it do
        expect {
          subject.pending_payment?
        }.to raise_error Tickets::Error::PendingPayment
      end
    end

    context 'when payment paid' do
      let(:ticket) { create(:ticket, status: :paid) }

      it { expect(subject.pending_payment?).to be_nil }
    end
  end

  describe '#payment_already_finalized?' do
    context 'when payment already finalized' do
      let(:ticket) { create(:ticket, status: :paid) }

      it do
        expect {
          subject.payment_already_finalized?
        }.to raise_error Tickets::Error::PaymentAlreadyFinalized
      end
    end

    context 'when payment not finalized' do
      let(:ticket) { create(:ticket, status: :pending) }

      it { expect(subject.payment_already_finalized?).to be_nil }
    end
  end

  describe '#invalid_plate?' do
    let(:ticket) {}

    context 'when invalid plate' do
      before { subject.params[:plate] = '123X' }

      it do
        expect {
          subject.invalid_plate?
        }.to raise_error Tickets::Error::InvalidPlate
      end
    end

    context 'when plate valid' do
      before { subject.params[:plate] = 'ABC-1234' }

      it { expect(subject.invalid_plate?).to be_nil }
    end
  end

  describe '#plate_already_out?' do
    context 'when plate already launched' do
      let(:ticket) { create(:ticket, leave_date: nil) }
      before { subject.params[:plate] = ticket.plate }

      it do
        expect {
          subject.plate_already_out?
        }.to raise_error Tickets::Error::PlateAlreadyLaunched
      end
    end

    context 'when plate didnt launched' do
      let(:ticket) {}
      before { subject.params[:plate] = 'ABC-1234' }

      it { expect(subject.plate_already_out?).to be_nil }
    end
  end
end
