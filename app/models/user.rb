# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :managed_events, foreign_key: 'admin_id', class_name: 'Event'
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, through: :attendances, source: :event
end
