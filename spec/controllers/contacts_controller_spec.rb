require 'rails_helper'

RSpec.describe ContactsController, type: :request do

  it 'returns http unauthorized' do
    get '/contacts'

    expect(response).to have_http_status(:unauthorized)
  end

  context 'when sign_in' do
    let(:user) { build :user }
    sign_in(:user)

    let(:contacts) { create_list(:contact, 50, user: user) }

    context '#index' do
      before(:each) do
        contacts
      end

      it 'get complete list' do
        get '/contacts'

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(20)
      end

      it 'get an empty list' do
        get '/contacts', { params: {page: 5} }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(0)
      end
    end

    context '#show' do
      it 'successful' do
        contacts

        get "/contacts/#{user.contacts.first.id}"
        expect(response).to have_http_status(:success)
      end

      it 'fails' do
        Contact.destroy_all
        get "/contacts/1"

        expect(response).to have_http_status(:not_found)
      end
    end

    context '#create' do
      let(:new_params) do
        { first_name: Faker::Name.first_name,
          phone: '55 5555-5555' }
      end

      it 'successful' do
        post '/contacts', params: new_params

        expect(response).to have_http_status(:success)
        expect(Contact.count).to eq(1)
      end

      it 'fails' do
        post '/contacts', params: {}

        expect(response).to have_http_status(422)
      end
    end

    context '#update' do
      let(:new_params) do
        { first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          address: "New address",
          phone: '55 5555-5555' }
      end

      it 'successful' do
        contact = contacts.first

        put "/contacts/#{contact.id}", params: new_params

        expect(response).to have_http_status(:success)

        contact.reload
        expect(contact.first_name).to eq(new_params[:first_name])
        expect(contact.last_name).to eq(new_params[:last_name])
        expect(contact.address).to eq(new_params[:address])
        expect(contact.phone).to eq(new_params[:phone])
      end

      it 'fails' do
        Contact.destroy_all
        put "/contacts/1"

        expect(response).to have_http_status(:not_found)
      end
    end

    context '#delete' do
      it 'successful' do
        contacts

        delete "/contacts/#{user.contacts.first.id}"
        expect(response).to have_http_status(:success)
      end

      it 'fails' do
        Contact.destroy_all
        delete "/contacts/1"

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
