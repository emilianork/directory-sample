require 'rails_helper'

RSpec.describe ProfileController, type: :request do
  describe 'PUT #update' do
    it 'returns http unauthorized' do
      put '/profile'

      expect(response).to have_http_status(:unauthorized)
    end

    context 'success' do
      let(:user) { build :user }
      sign_in(:user)

      it 'on empty json' do
        put '/profile'

        expect(response).to have_http_status(:success)
      end

      let(:new_params) do
        { first_name: Faker::Name.first_name,
          last_name:  Faker::Name.last_name }
      end

      it 'on permitted params' do
        put '/profile', params: new_params

        user.reload

        expect(response).to have_http_status(:success)

        expect(user.first_name).to eq(new_params[:first_name])
        expect(user.last_name).to eq(new_params[:last_name])
      end

      it 'on wrong params' do
        put '/profile', params: { something: 'not valid' }

        expect(response).to have_http_status(:success)
      end
    end
  end
end
