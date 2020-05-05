# frozen_string_literal: true

module Tickets
  module Error
    class ReserveAlreadyDeallocated < StandardError; end
    class PendingPayment            < StandardError; end
    class PaymentAlreadyFinalized   < StandardError; end
    class InvalidPlate              < StandardError; end
    class PlateAlreadyLaunched      < StandardError; end
  end
end
