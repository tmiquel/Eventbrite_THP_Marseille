# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send
  has_many :managed_events, foreign_key: 'admin_id', class_name: 'Event'
  has_many :attendances, foreign_key: 'attendee_id'
  has_many :attended_events, through: :attendances, source: :event
  validates :email, presence: true, uniqueness: true

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def self.find_by_email(events_param)
    User.where(email: events_param[:admin_email])
  end
end
