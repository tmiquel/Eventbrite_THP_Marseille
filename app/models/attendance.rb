# frozen_string_literal: true

class Attendance < ApplicationRecord
  after_create :new_attendee_notif_to_admin_email
  belongs_to :event
  belongs_to :attendee, class_name: 'User'
  validates :stripe_customer_id, presence: true, uniqueness: true

  def new_attendee_notif_to_admin_email
    byebug
    AttendanceMailer.new_attendee_notif_to_admin_email(event.admin, attendee, event).deliver_now
  end
end
