# frozen_string_literal: true

class Ticket < ApplicationRecord
  validates :plate, presence: true
  validates :code,  uniqueness: { case_sensitive: false }
  validates_with PlateValidator

  enum status: %w[pending paid]

  include CodeGenerator
  include Reservation
  include Paginatable

  before_create :set_alphanumeric_code
end
