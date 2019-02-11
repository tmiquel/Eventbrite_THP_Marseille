# frozen_string_literal: true

json.extract! attendance, :id, :event_id, :user_id, :stripe_customer_id, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
