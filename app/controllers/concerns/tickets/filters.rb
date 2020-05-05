# frozen_string_literal: true

module Tickets
  extend Tickets::Error

  module Filters
    extend ActiveSupport::Concern

    def reserve_already_deallocated?
      raise Tickets::Error::ReserveAlreadyDeallocated if @ticket.left?
    end

    def pending_payment?
      raise Tickets::Error::PendingPayment unless @ticket.paid?
    end

    def payment_already_finalized?
      raise Tickets::Error::PaymentAlreadyFinalized if @ticket.paid?
    end

    def invalid_plate?
      raise Tickets::Error::InvalidPlate unless PlateValidator.valid?(params[:plate])
    end

    def plate_already_out?
      if Ticket.find_by(plate: params[:plate], leave_date: nil)
        raise Tickets::Error::PlateAlreadyLaunched
      end
    end
  end
end
