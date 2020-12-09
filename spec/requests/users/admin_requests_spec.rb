require 'rails_helper'

RSpec.describe 'Users as :admin', type: :request do
  let(:admin) { create :admin }
  let(:headers) { auth_header admin }

  context 'GET /users' do
    let(:url) { '/users' }

    it 'returns all users' do
      get url, headers: headers
      expect(json_body.count).to be > 0
    end
  end

  context 'GET /users/:id' do
    let(:user) { create(:user) }
    let(:url) { "/users/#{user.id}" }

    it 'returns requested User' do
      get url, headers: headers
      expect(json_body['id']).to eq user.id
    end

    it 'returns success status' do
      get url, headers: headers
      expect(response).to have_http_status :ok
    end
  end

  context 'PATCH /users/:id' do
    let(:user) { create(:user) }
    let(:url) { "/users/#{user.id}" }

    context 'with valid params' do
      let(:new_first_name) { 'New first name' }
      let(:user_params) do
        { user: attributes_for(:user, first_name: new_first_name) }
      end

      it 'returns updated User' do
        patch url, headers: headers, params: user_params
        expect(json_body['first_name']).to eq new_first_name
      end

      it 'returns success status' do
        patch url, headers: headers, params: user_params
        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid params' do
      let(:user_invalid_params) do
        { user: attributes_for(:user, :invalid) }
      end

      it 'returns error message' do
        patch url, headers: headers, params: user_invalid_params
        expect(json_body).to have_key 'first_name'
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: headers, params: user_invalid_params
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  context 'DELETE /users/:id' do
    let!(:user) { create :user }
    let(:url) { "/users/#{user.id}" }

    it 'discards User' do
      delete url, headers: headers
      expect(User.kept.find_by_id(user.id)).to be_nil
    end

    it 'returns success status' do
      delete url, headers: headers
      expect(response).to have_http_status :no_content
    end

    it 'does not return any body content' do
      delete url, headers: headers
      expect(json_body).to_not be_present
    end
  end
end
