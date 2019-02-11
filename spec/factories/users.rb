# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(13, 25, true, true) }
    description { Faker::Lorem.paragraph_by_chars(256, false) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
