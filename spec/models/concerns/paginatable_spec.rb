# frozen_string_literal: true

require 'rails_helper'

describe Paginatable do
  describe '#paginate' do
    subject { Ticket.paginate(params) }

    context 'without pagination parameters' do
      let(:params) { {} }

      it do
        is_expected.to have_attributes(current_page: 1, limit_value: 10)
      end
    end

    context 'with pagination parameters' do
      let(:params) { { page: 2, per_page: 2 } }

      it { is_expected.to have_attributes(current_page: 2, limit_value: 2) }
    end

    context 'with invalid pagination parameters' do
      let(:params) { { page: 'x', per_page: 'y' } }

      it { is_expected.to have_attributes(current_page: 1, limit_value: 10) }
    end
  end
end
