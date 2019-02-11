# frozen_string_literal: true

require 'rails_helper'

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before(:each) do
    @attendance = FactoryBot.create(:attendance)
  end

  it 'has a valid factory' do
    # teste toujours tes factories pour voir si elles sont valides
    expect(build(:attendance)).to be_valid
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(@attendance).to be_a(Attendance)
    end

    describe '#stripe_customer_id' do
      it { expect(@attendance).to validate_presence_of(:stripe_customer_id) }
    end
  end
end
