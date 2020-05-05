# frozen_string_literal: true

require 'rails_helper'

describe Reservation do
  let(:ticket) { create(:ticket) }

  describe '#close_reservation!' do
    before { ticket.close_reservation! }
    it { expect(ticket.leave_date).to be_a_kind_of(Time) }
  end

  describe '#elapsed_time_in_words' do
    before do
      ticket
      Timecop.freeze(Time.current + time)
      ticket.close_reservation!
    end

    context 'when seconds' do
      let(:time) { 21.seconds }
      it { expect(ticket.elapsed_time_in_words).to eql('1 minute') }
    end

    context 'when minutes' do
      let(:time) { 2.minutes }
      it { expect(ticket.elapsed_time_in_words).to eql('2 minutes') }
    end

    context 'when hours' do
      let(:time) { 3.hours }
      it { expect(ticket.elapsed_time_in_words).to eql('3 hours') }
    end

    context 'when complex time' do
      let(:time) { 2_789_112.seconds }
      it do
        expect(ticket.elapsed_time_in_words).to eql(
          '32 days, 6 hours, and 45 minutes'
        )
      end
    end
  end

  describe '#left?' do
    context 'when reservation closed' do
      before { ticket.close_reservation! }
      it { expect(ticket.left?).to be_truthy }
    end

    context 'when reservation not closed' do
      let(:ticket) { create(:ticket, leave_date: nil) }

      it { expect(ticket.left?).to be_falsey }
    end
  end
end
