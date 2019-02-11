# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances/new', type: :view do
  before(:each) do
    assign(:attendance, Attendance.new(
                          event: FactoryBot.create(:event),
                          attendee: FactoryBot.create(:user),
                          stripe_customer_id: 'MyString'
                        ))
  end

  it 'renders new attendance form' do
    render

    assert_select 'form[action=?][method=?]', attendances_path, 'post' do
      assert_select 'input[name=?]', 'attendance[event_id]'

      assert_select 'input[name=?]', 'attendance[user_id]'

      assert_select 'input[name=?]', 'attendance[stripe_customer_id]'
    end
  end
end
