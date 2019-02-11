# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances/index', type: :view do
  before(:each) do
    assign(:attendances, [
             Attendance.create!(
               event: FactoryBot.create(:event),
               attendee: FactoryBot.create(:user),
               stripe_customer_id: rand(10).to_s
             ),
             Attendance.create!(
               event: FactoryBot.create(:event),
               attendee: FactoryBot.create(:user),
               stripe_customer_id: rand(10).to_s
             )
           ])
  end

  # it "renders a list of attendances" do
  #   render
  #   assert_select "tr>td", :text => nil.to_s, :count => 2
  #   assert_select "tr>td", :text => nil.to_s, :count => 2
  #   assert_select "tr>td", :text => "Stripe Customer".to_s, :count => 2
  # end
end
