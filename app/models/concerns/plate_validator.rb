# frozen_string_literal: true

class PlateValidator < ActiveModel::Validator
  PLATE_MASK = /\A\w{3}-\d{4}\Z/

  def self.valid?(plate)
    !!(plate =~ PLATE_MASK)
  end

  def validate(record)
    unless self.class.valid?(record.plate)
      record.errors.add :plate, message(record.plate)
    end
  end

  private

  def message(plate)
    '%s is invalid! Expected format: XYZ-1234' % plate
  end
end
