# frozen_string_literal: true

module CodeGenerator
  extend ActiveSupport::Concern

  def set_alphanumeric_code
    self.code = alphanumeric_code
  end

  private

  def alphanumeric_code
    SecureRandom.base36.upcase
  end
end
