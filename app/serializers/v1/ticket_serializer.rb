# frozen_string_literal: true

module V1
  class TicketSerializer < ApplicationSerializer
    attributes :id, :code, :plate, :left, :time, :paid, :created_at, :updated_at

    def time
      object.elapsed_time_in_words
    end

    def left
      object.left?
    end

    def paid
      object.paid?
    end
  end
end
