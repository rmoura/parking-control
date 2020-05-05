# frozen_string_literal: true

require 'rails_helper'

describe Serializable do
  subject do
    Class.new(V1::TicketsController) { extend Serializable }
  end

  describe '#serialize' do
    it do
      expect(
        subject.serialize(Ticket.paginate)
      ).to be_a_kind_of(CollectionSerializer)
    end
  end
end
