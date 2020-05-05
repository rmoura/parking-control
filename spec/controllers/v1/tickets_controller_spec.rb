# frozen_string_literal: true

require 'rails_helper'

describe V1::TicketsController do
  let(:parsed_body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'POST #create' do
    context 'with invalid params' do
      let(:response) { post :create }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(response.body).to include('is invalid!') }
    end

    context 'with valid params' do
      let(:response) { post :create, params: { plate: 'ABC-1234' } }

      it { expect(response).to have_http_status :created }
      it { expect(parsed_body).to include(plate: 'ABC-1234') }
    end
  end

  describe 'PUT #out' do
    let(:ticket) { create(:ticket, status: status) }
    let(:status) { :pending }
    let(:response) { put :out, params: { id: ticket.id } }

    context 'with reserve already deallocated' do
      let(:status) { :paid }

      it { expect(response).to have_http_status :unprocessable_entity }

      it do
        expect(response.body).to include "Reserve #{ticket.code} already deallocated"
      end
    end

    context 'with pending payment' do
      let(:ticket) { create(:ticket, status: status, leave_date: nil) }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(response.body).to include 'Pending payment' }
    end

    context 'when payment successful updated' do
      let(:ticket) { create(:ticket, status: status, leave_date: nil) }
      let(:status) { :paid }

      it { expect(response).to have_http_status :ok }
      it { expect(parsed_body).to include(left: true) }
    end
  end

  describe 'PUT #pay' do
    let(:response) { put :pay, params: { id: ticket.id } }
    let(:ticket) { create(:ticket, status: status, leave_date: nil) }

    context 'when payment already finalized' do
      let(:status) { :paid }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(response.body).to include 'Payment already finalized!' }
    end

    context 'when payment not finalized' do
      let(:status) { :pending }

      it { expect(response).to have_http_status :ok }
      it { expect(parsed_body).to include(paid: true) }
    end
  end

  describe 'GET #show' do
    let(:response) { get :show, params: { plate: plate } }

    context 'when plate is invalid' do
      let(:plate) { 'ABCD-123' }

      it { expect(response).to have_http_status :unprocessable_entity }
      it do
        expect(parsed_body).to include(
          errors: 'plate ABCD-123 is invalid! Expected format: XYZ-1234'
        )
      end
    end

    context 'when valid plate' do
      let(:plate) { create(:ticket, leave_date: nil).plate }

      it { expect(response).to have_http_status :ok }
      it do
        expect(parsed_body).to include(
          current_page: 1,
          entries: a_collection_containing_exactly(include(plate: plate)),
          per_page: 10,
          total_entries: 1
        )
      end
    end
  end
end
