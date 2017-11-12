require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:contacts) }
  end

  context 'validations' do
    context 'email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to allow_value('user@example.com').for(:email) }
      it { is_expected.to_not allow_value('not-an-email').for(:email) }
    end


    context 'first_name' do
      it {
        is_expected.to validate_length_of(:first_name)
                         .is_at_least(2)
                         .is_at_most(50)
      }

      it { is_expected.to allow_value(nil).for(:first_name) }
    end


    context 'last_name' do
      it {
        is_expected.to validate_length_of(:last_name)
                         .is_at_least(2)
                         .is_at_most(50)
      }

      it { is_expected.to allow_value(nil).for(:last_name) }
    end
  end
end
