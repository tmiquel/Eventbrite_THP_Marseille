# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  has_many :attendances
  has_many :attendees, through: :attendances, source: :attendee
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validates :duration, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
  validate :duration_is_multiple_of_5
  validates :title, presence: true,
                    length: { in: 5..140 }
  validates :description, presence: true,
                          length: { in: 20..1000 }
  validates :price, presence: true,
                    numericality: { greater_than: 0, less_than: 1001 }
  validates :location, presence: true

  def end_date
    start_date + duration * 60
  end

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def duration_is_multiple_of_5
    if duration.present? && duration.instance_of?(Integer) && ((duration % 5) != 0)
      errors.add(:duration, 'shall be a multiple of 5')
    end
  end
end
