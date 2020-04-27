# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    cost     { Random.rand * 100 }
    discount { 0 }
    total    { cost - discount }
  end
end
