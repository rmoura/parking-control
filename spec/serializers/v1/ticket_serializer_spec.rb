# frozen_string_literal: true

require 'rails_helper'

describe V1::TicketSerializer do
  let(:ticket) { create(:ticket, leave_date: nil) }

  it do
    expect(
      V1::TicketSerializer.new(ticket).as_json
    ).to include(
      id: a_kind_of(Integer),
      code: a_value,
      plate: a_value,
      left: a_falsey_value,
      time: '1 minute',
      paid: a_falsey_value,
      created_at: a_kind_of(Time),
      updated_at: a_kind_of(Time)
    )
  end
end
