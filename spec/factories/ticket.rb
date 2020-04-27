# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    plate { Faker::Vehicle.license_plate }
    code  { Faker::Vehicle.license_plate }
  end
end
