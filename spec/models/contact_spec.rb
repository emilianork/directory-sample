require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'db_indexes' do
    it { is_expected.to have_db_index([:user_id, :id]).unique }
  end

  context 'validations' do
    context 'first_name' do
      it { is_expected.to validate_presence_of(:first_name) }
      it {
        is_expected.to validate_length_of(:first_name)
          .is_at_least(2)
          .is_at_most(50)
      }
    end

    context 'last_name' do
      it {
        is_expected.to validate_length_of(:last_name)
                         .is_at_least(2)
                         .is_at_most(50)
      }

      it { is_expected.to allow_value(nil).for(:last_name) }
    end


    context 'address' do
      it {
        is_expected.to validate_length_of(:address)
                         .is_at_least(5)
                         .is_at_most(250)
      }

      it { is_expected.to allow_value(nil).for(:address) }
    end

    context 'phone' do
      it { is_expected.to validate_presence_of(:phone) }
      it { is_expected.to allow_value('55 5555-5555').for(:phone) }
      it { is_expected.to_not allow_value('not-allow-number').for(:phone) }
    end
  end
end
