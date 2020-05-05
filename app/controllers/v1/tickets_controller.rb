# frozen_string_literal: true

module V1
  class TicketsController < ApplicationController
    before_action :find_ticket, except: %i[create show]

    include Tickets::ErrorHandler
    include Tickets::Filters
    include Serializable

    before_action :plate_already_out?, only: :create
    before_action :reserve_already_deallocated?, only: :out
    before_action :pending_payment?, only: :out
    before_action :payment_already_finalized?, only: :pay
    before_action :invalid_plate?, only: :show

    def create
      ticket = Ticket.create!(permitted_params)
      render json: ticket, status: :created
    end

    def out
      @ticket.close_reservation!
      render json: @ticket, status: :ok
    end

    def pay
      @ticket.update!(status: :paid)
      render json: @ticket, status: :ok
    end

    def show
      tickets = Ticket.where(plate: params[:plate])
                      .order(id: :desc)
                      .paginate(pagination_params)

      render json: serialize(tickets, TicketSerializer)
    end

    private

    def permitted_params
      params.permit(:plate)
    end

    def find_ticket
      @ticket = Ticket.find(params[:id])
    end

    def pagination_params
      params.permit(:page, :per_page)
    end
  end
end
