# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'User'
  validates :stripe_customer_id, presence: true, uniqueness: true
end
