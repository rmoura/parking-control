# frozen_string_literal: true

class Ticket < ApplicationRecord
  # Validations
  validates :plate, :code, presence: true
  validates :plate, :code, uniqueness: { case_sensitive: false }

  # Relations
  has_one :payment, dependent: :nullify
end
