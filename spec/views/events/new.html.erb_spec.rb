# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/new', type: :view do
  before(:each) do
    assign(:event, Event.new(
                     admin: FactoryBot.create(:user),
                     start_date: Time.now + 5_761_812,
                     duration: 1,
                     title: 'MyString',
                     description: 'MyTextbscljabkscqkjcbkqsdjcbqskdjcbnqskjdhqskjdhqskjdhqskdjh',
                     price: 1,
                     location: 'MyString'
                   ))
  end

  # it "renders new event form" do
  #   render

  #   assert_select "form[action=?][method=?]", events_path, "post" do

  #     assert_select "input[name=?]", "event[admin_id]"

  #     assert_select "input[name=?]", "event[duration]"

  #     assert_select "input[name=?]", "event[title]"

  #     assert_select "textarea[name=?]", "event[description]"

  #     assert_select "input[name=?]", "event[price]"

  #     assert_select "input[name=?]", "event[location]"
  #   end
  # end
end
