# frozen_string_literal: true

class Payment < ApplicationRecord
  # Validations
  validates :cost_cents, :discount_cents, :total_cents,
    numericality: { greater_than_or_equal: 0 }

  # Config
  monetize :cost_cents, :discount_cents, :total_cents, allow_nil: false

  # Relations
  belongs_to :ticket
end
