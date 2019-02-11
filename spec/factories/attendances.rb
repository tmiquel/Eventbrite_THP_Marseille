# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    event { FactoryBot.create(:event) }
    attendee { FactoryBot.create(:user) }
    stripe_customer_id { Faker::Number.unique.number(10) }
  end
end
