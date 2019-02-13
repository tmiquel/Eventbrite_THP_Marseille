# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
                            email: 'thibaut.miquel@yopmail.com',
                            password: 'Password Digest',
                            description: 'MyTextbscljabkscqkjcbkqsdjcbqskdjcbnqskjdhqskjdhqskjdhqskdjh',
                            first_name: 'My First Name',
                            last_name: 'My Last Name'
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/thibaut.miquel@yopmail.com/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/My First Name/)
    expect(rendered).to match(/My Last Name/)
  end
end
