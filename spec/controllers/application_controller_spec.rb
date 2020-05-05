# frozen_string_literal: true

require 'rails_helper'

describe ApplicationController do
  describe '#not_found', type: :request do
    context 'when GET request for page not found' do
      before { get '/blah' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to include('API endpoint Not Found!') }
    end

    context 'when POST request for page not found' do
      before { post '/blah' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to include('API endpoint Not Found!') }
    end

    context 'when PUT request for page not found' do
      before { put '/blah' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to include('API endpoint Not Found!') }
    end

    context 'when DELETE request for page not found' do
      before { delete '/blah' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to include('API endpoint Not Found!') }
    end
  end
end
