# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances/show', type: :view do
  before(:each) do
    @strip_customer_id = rand(10).to_s
    @attendance = assign(:attendance, Attendance.create!(
                                        event: FactoryBot.create(:event),
                                        attendee: FactoryBot.create(:user),
                                        stripe_customer_id: @strip_customer_id
                                      ))
  end

  # it "renders attributes in <p>" do
  #   render

  #   expect(rendered).to match(/@strip_customer_id/)
  # end
end
