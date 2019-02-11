# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    admin { FactoryBot.create(:user) }
    start_date { Faker::Date.forward(365) }
    duration { rand(1..10) * 5 }
    title { Faker::Lorem.paragraph_by_chars(50, false) }
    description { Faker::Lorem.paragraph_by_chars(256, false) }
    price { rand(1..1000) }
    location { Faker::Nation.capital_city }
  end
end
