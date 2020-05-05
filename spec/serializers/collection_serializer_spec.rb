# frozen_string_literal: true

require 'rails_helper'

describe CollectionSerializer do
  subject { CollectionSerializer.new(Ticket.paginate, serializer) }

  describe '#as_json' do
    context 'with serializer' do
      let(:serializer) { V1::TicketSerializer }

      it do
        expect(subject.as_json).to include(
          current_page: a_kind_of(Integer),
          per_page: a_kind_of(Integer),
          total_entries: a_kind_of(Integer),
          entries: a_kind_of(ActiveModelSerializers::SerializableResource)
        )
      end

      it { expect(subject).to have_attributes(serializer: V1::TicketSerializer) }
    end
  end
end
