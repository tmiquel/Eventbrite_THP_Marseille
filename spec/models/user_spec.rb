# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it 'has a valid factory' do
    # teste toujours tes factories pour voir si elles sont valides
    expect(build(:user)).to be_valid
  end

  context 'associations' do
    describe 'attendances' do
      it { expect(@user).to have_many(:attendances) }
    end

    describe 'attended_events' do
      it { expect(@user).to have_many(:attended_events) }
    end

    describe 'managed_events' do
      it { expect(@user).to have_many(:managed_events) }
    end
  end
end
