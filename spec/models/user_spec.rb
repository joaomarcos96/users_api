require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:invalid_user) { build(:user, :invalid) }
  let(:discarded_user) do
    user = create(:user)
    user.discard
    user
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }

    context 'with valid attributes' do
      it { expect(user).to be_valid }
    end

    context 'with invalid attributes' do
      it { expect(invalid_user).to_not be_valid }
    end
  end

  describe 'roles' do
    context 'when not admin' do
      it { expect(user).to_not be_admin }
    end

    context 'when admin' do
      it { expect(admin).to be_admin }
    end
  end

  context 'when discarded' do
    it { expect(discarded_user).to_not be_active_for_authentication }
  end

  context 'when not discarded' do
    it { expect(user).to be_active_for_authentication }
  end
end
