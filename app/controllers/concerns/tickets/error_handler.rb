# frozen_string_literal: true

module Tickets
  module ErrorHandler
    extend ActiveSupport::Concern

    def reserve_already_deallocated(*)
      render(
        json:   { errors: 'Reserve %s already deallocated' % @ticket.code },
        status: :unprocessable_entity
      )
    end

    def pending_payment(*)
      render(
        json:   { errors: 'Pending payment!' },
        status: :unprocessable_entity
      )
    end

    def payment_already_finalized(*)
      render(
        json:   { errors: 'Payment already finalized!' },
        status: :unprocessable_entity
      )
    end

    def plate_already_launched(*)
      render(
        json:   { errors: 'Plate already launched previously!' },
        status: :unprocessable_entity
      )
    end

    def invalid_plate(*)
      render(
        json: {
          errors: 'plate %s is invalid! Expected format: XYZ-1234' % params[:plate]
        },
        status: :unprocessable_entity
      )
    end

    private

    def error_mapping
      super.merge(
        reserve_already_deallocated: Tickets::Error::ReserveAlreadyDeallocated,
        pending_payment:             Tickets::Error::PendingPayment,
        payment_already_finalized:   Tickets::Error::PaymentAlreadyFinalized,
        invalid_plate:               Tickets::Error::InvalidPlate,
        plate_already_launched:      Tickets::Error::PlateAlreadyLaunched
      )
    end
  end
end
