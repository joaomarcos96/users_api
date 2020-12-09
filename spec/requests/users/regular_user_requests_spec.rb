require 'rails_helper'

RSpec.describe 'Users as :user', type: :request do
  let(:user) { create :user }
  let(:headers) { auth_header user }
  let(:url) { "/users/#{user.id}" }

  let(:another_user) { create :user }
  let(:another_user_url) { "/users/#{another_user.id}" }

  context 'GET /users' do
    let(:url) { '/users' }

    it 'returns only one record' do
      get url, headers: headers
      expect(json_body.count).to eq 1
    end
  end

  context 'GET /users/:id' do
    context 'when trying to GET another User' do
      it 'returns not found' do
        get another_user_url, headers: headers
        expect(response).to have_http_status :not_found
      end
    end

    context 'when trying to GET itself' do
      it 'returns requested data' do
        get url, headers: headers
        expect(json_body['id']).to eq user.id
      end

      it 'returns success status' do
        get url, headers: headers
        expect(response).to have_http_status :ok
      end
    end
  end

  context 'PATCH /users/:id' do
    context 'when trying to PATCH another User' do
      it 'returns not found' do
        patch another_user_url, headers: headers
        expect(response).to have_http_status :not_found
      end
    end

    context 'when trying to PATCH itself' do
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
  end

  context 'DELETE /users/:id' do
    context 'when trying to DELETE another User' do
      it 'returns not found' do
        delete another_user_url, headers: headers
        expect(response).to have_http_status :not_found
      end
    end

    context 'when trying to DELETE itself' do
      it 'discards User ceasing access' do
        delete url, headers: headers
        expect(User.kept.find_by(id: user.id)).to be_nil

        get url, headers: headers
        expect(response).to have_http_status :not_found
      end
    end
  end
end
