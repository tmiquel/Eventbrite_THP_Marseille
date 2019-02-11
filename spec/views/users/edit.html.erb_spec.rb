# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
                            email: 'MyString',
                            password_digest: 'MyString',
                            description: 'MyTextbscljabkscqkjcbkqsdjcbqskdjcbnqskjdhqskjdhqskjdhqskdjh',
                            first_name: 'MyString',
                            last_name: 'MyString'
                          ))
  end

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(@user), 'post' do
      assert_select 'input[name=?]', 'user[email]'

      assert_select 'input[name=?]', 'user[password_digest]'

      assert_select 'textarea[name=?]', 'user[description]'

      assert_select 'input[name=?]', 'user[first_name]'

      assert_select 'input[name=?]', 'user[last_name]'
    end
  end
end