# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

describe 'Tickets API' do
  path '/parking' do
    post 'CREATE Ticket' do
      tags 'Tickets'
      consumes 'application/json'
      parameter name: :body, in: :body

      request_body_json schema: {
        type: :object,
        properties: {
          plate: { type: :string, example: 'ABC-1234' }
        },
        required: %w[plate]
      }

      response '201', 'ticket created' do
        schema type: :object,
          properties: {
            id: { type: :integer, example: 1 },
            code: { type: :string, example: 'XYZ123' },
            plate: { type: :string, example: 'ABC-1234' },
            left: { type: :boolean, example: true },
            time: { type: :string, example: '1 minute' },
            paid: { type: :boolean, example: true },
            created_at: { type: :string, example: '2020-12-13 20:20:34' },
            updated_at: { type: :string, example: '2020-12-13 20:20:34' }
          }

        let(:body) { { plate: 'ABC-1234' } }

        run_test!
      end

      response '422', 'plate didnt out' do
        schema type: :object,
          properties: {
            errors: { example: 'plate  is invalid! Expected format: XYZ-1234' }
          }

        let(:body) { { plate: 'AB1-234' } }

        run_test!
      end
    end
  end

  path '/parking/{id}/out' do
    put 'Checkout Ticket' do
      tags 'Tickets'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'ticket updated' do
        schema type: :object,
          properties: {
            id: { type: :integer, example: 1 },
            code: { type: :string, example: 'XYZ123' },
            plate: { type: :string, example: 'ABC-1234' },
            left: { type: :boolean, example: true },
            time: { type: :string, example: '1 minute' },
            paid: { type: :boolean, example: true },
            created_at: { type: :string, example: '2020-12-13 20:20:34' },
            updated_at: { type: :string, example: '2020-12-13 20:20:34' }
          },
          required: []

        let(:id) { create(:ticket, leave_date: nil, status: :paid).id }

        run_test!
      end

      response '404', 'ticket not found' do
        schema type: :object,
          properties: {
            errors: { example: "Couldn't find Ticket with 'id'=23" }
          }

        let(:id) { 23 }

        run_test!
      end

      response '422', 'plate already out' do
        schema type: :object,
          properties: {
            errors: { example: 'Reserve AVX1SDS already deallocated' }
          }

        let(:ticket) { create(:ticket) }
        let(:id) { ticket.id }

        run_test!
      end

      response '422', 'pending payment' do
        schema type: :object,
          properties: {
            errors: { example: 'Pending payment!' }
          }

        let(:ticket) { create(:ticket, leave_date: nil) }
        let(:id) { ticket.id }

        run_test!
      end
    end
  end

  path '/parking/{id}/pay' do
    put 'PAY Ticket' do
      tags 'Tickets'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'ticket updated' do
        schema type: :object,
          properties: {
            id: { type: :integer, example: 1 },
            code: { type: :string, example: 'XYZ123' },
            plate: { type: :string, example: 'ABC-1234' },
            left: { type: :boolean, example: true },
            time: { type: :string, example: '1 minute' },
            paid: { type: :boolean, example: true },
            created_at: { type: :string, example: '2020-12-13 20:20:34' },
            updated_at: { type: :string, example: '2020-12-13 20:20:34' }
          },
          required: []

        let(:id) { create(:ticket).id }

        run_test!
      end

      response '404', 'ticket not found' do
        schema type: :object,
          properties: {
            errors: { example: "Couldn't find Ticket with 'id'=23" }
          }

        let(:id) { 23 }

        run_test!
      end

      response '422', 'payment already finalized' do
        schema type: :object,
          properties: {
            errors: { example: 'Payment already finalized!' }
          }

        let(:ticket) { create(:ticket, status: :paid) }
        let(:id) { ticket.id }

        run_test!
      end
    end
  end

  path '/parking/{plate}' do
    get 'Retrieves a ticket' do
      tags 'Tickets'
      produces 'application/json'
      parameter name: :plate, in: :path, type: :string

      response '200', 'tickets found' do
        schema type: :object,
          properties: {
            current_page: { type: :integer, example: 1 },
            per_page: { type: :integer, example: 10 },
            total_entries: { type: :integer, example: 397 },
            entries: {
              type: :array, example: [
                {
                  id: 1,
                  code: 'VK6STJ4MMOW2QAKJ',
                  plate: 'ABC-1234',
                  left: true,
                  time: '1 minute',
                  paid: true,
                  'created_at': '2020-05-01T12:47:18.621-03:00',
                  'updated_at': '2020-05-01T12:48:14.100-03:00'
                }
              ]
            }
          }

        let(:plate) { 'ABC-1234' }

        run_test!
      end

      response '200', 'tickets not found' do
        schema type: :object,
          properties: {
            current_page: { type: :integer, example: 1 },
            per_page: { type: :integer, example: 10 },
            total_entries: { type: :integer, example: 0 },
            entries: {
              type: :array, example: []
            }
          }

        let(:plate) { 'ABC-1234' }

        run_test!
      end

      response '422', 'plate not valid' do
        schema type: :object,
          properties: {
            errors: { example: 'plate is invalid! Expected format: XYZ-1234' }
          }

        let(:plate) { 'A12-CDF' }

        run_test!
      end
    end
  end
end
