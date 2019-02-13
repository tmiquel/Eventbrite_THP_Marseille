# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before(:each) do
    @user = assign(:user, FactoryBot.create(:user))
  end

  it 'renders new user form' do
    render

    # assert_select 'form[action=?][method=?]', users_path, 'post' do
    #   assert_select 'input[name=?]', 'user[email]'

    #   assert_select 'textarea[name=?]', 'user[description]'

    #   assert_select 'input[name=?]', 'user[first_name]'

    #   assert_select 'input[name=?]', 'user[last_name]'
    # end
  end
end
