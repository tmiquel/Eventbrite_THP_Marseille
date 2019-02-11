# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    @event = FactoryBot.create(:event)
  end

  it 'has a valid factory' do
    # teste toujours tes factories pour voir si elles sont valides
    expect(build(:event)).to be_valid
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(@event).to be_a(Event)
    end

    describe '#start_date' do
      it { expect(@event).to validate_presence_of(:start_date) }
      it { expect(@event.start_date).to be_future }
    end

    describe '#duration' do
      it { expect(@event).to validate_presence_of(:duration) }
      it {
        expect(@event).to validate_numericality_of(:duration)
          .only_integer
          .is_greater_than(0)
      }
    end

    describe '#title' do
      it { expect(@event).to validate_presence_of(:title) }
      it {
        expect(@event).to validate_length_of(:title)
          .is_at_least(5).is_at_most(140)
      }       # 5..140
    end

    describe '#description' do
      it { expect(@event).to validate_presence_of(:description) }
      it {
        expect(@event).to validate_length_of(:description)
          .is_at_least(20).is_at_most(1000)
      }       # 20..1000
    end

    describe '#price' do
      it { expect(@event).to validate_presence_of(:price) }
      it {
        expect(@event).to validate_numericality_of(:price)
          .is_less_than(1001)
          .is_greater_than(0)
      }
    end

    describe '#location' do
      it { expect(@event).to validate_presence_of(:location) }
    end
  end

  context 'associations' do
    describe 'attendances' do
      it { expect(@event).to have_many(:attendances) }
    end

    describe 'attendees' do
      it { expect(@event).to have_many(:attendees) }
    end
  end
end
