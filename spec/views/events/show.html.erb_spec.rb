# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/show', type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
                              admin: FactoryBot.create(:user),
                              start_date: Time.now + 5_761_812,
                              duration: 5,
                              title: 'Title',
                              description: 'MyTextbscljabkscqkjcbkqsdjcbqskdjcbnqskjdhqskjdhqskjdhqskdjh',
                              price: 3,
                              location: 'Location'
                            ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Start/)

    expect(rendered).to match(/2/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Location/)
  end
end
