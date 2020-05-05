# frozen_string_literal: true

require 'rails_helper'

describe ErrorHandler do
  describe '#render_not_found', type: :request do
    before { put '/parking/1999/out' }

    it { expect(response).to have_http_status :not_found }
    it { expect(response.body).to include 'Couldn\'t find Ticket' }
  end

  describe '#render_unprocessable_entity', type: :request do
    before { post '/parking' }

    it { expect(response).to have_http_status :unprocessable_entity }
    it { expect(response.body).to include 'plate  is invalid!' }
  end

  describe '#render_internal_server_error', type: :request do
    before do
      allow(Ticket).to receive(:find).and_raise(ArgumentError)
      put '/parking/1999/out'
    end

    it { expect(response).to have_http_status :internal_server_error }
  end
end
