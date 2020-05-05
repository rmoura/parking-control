# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    plate { Faker::Vehicle.license_plate }
    code  {
      Faker::Number.between(
        from: 1_000_000_000_000_000,
        to:   9_999_999_999_999_999
      )
    }
    leave_date { Faker::Date.backward }
  end
end
