# frozen_string_literal: true

class ErrorSerializer < ApplicationSerializer
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def serialize
    record.errors.messages.map do |field, details|
      details.map { |detail| '%s %s' % [field, detail] }
    end.flatten
  end
end
