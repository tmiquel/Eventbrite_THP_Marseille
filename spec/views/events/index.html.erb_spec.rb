# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  before(:each) do
    assign(:events, [
             Event.create!(
               admin: FactoryBot.create(:user),
               start_date: Time.now + 4_671_527,
               duration: 5,
               title: 'Title',
               description: 'MyTextbscljabkscqkjcbkqsdjcbqskdjcbnqskjdhqskjdhqskjdhqskdjh',
               price: 3,
               location: 'Location'
             ),
             Event.create!(
               admin: FactoryBot.create(:user),
               duration: 5,
               start_date: Time.now + 4_671_527,
               title: 'Title',
               description: 'MyTextbscljabkscqkjcbkqsdjcbqskdjcbnqskjdhqskjdhqskjdhqskdjh',
               price: 3,
               location: 'Location'
             )
           ])
  end

  # it "renders a list of events" do
  #   render
  #   assert_select "tr>td", :text => "Start".to_s, :count => 2
  #   assert_select "tr>td", :text => nil.to_s, :count => 2
  #   assert_select "tr>td", :text => 2.to_s, :count => 2
  #   assert_select "tr>td", :text => "Title".to_s, :count => 2
  #   assert_select "tr>td", :text => "MyText".to_s, :count => 2
  #   assert_select "tr>td", :text => 3.to_s, :count => 2
  #   assert_select "tr>td", :text => "Location".to_s, :count => 2
  # end
end
