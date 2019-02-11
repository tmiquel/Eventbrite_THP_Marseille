# frozen_string_literal: true

json.extract! user, :id, :email, :password_digest, :description, :first_name, :last_name, :created_at, :updated_at
json.url user_url(user, format: :json)