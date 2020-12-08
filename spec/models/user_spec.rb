require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
  end

  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:invalid_user) { build(:user, :invalid) }

  context 'with valid attributes' do
    it { expect(user).to be_valid }
  end

  context 'with invalid attributes' do
    it { expect(invalid_user).to_not be_valid }
  end

  describe 'roles' do
    context 'when not admin' do
      it { expect(user).to_not be_admin }
    end

    context 'when admin' do
      it { expect(admin).to_not be_admin }
    end
  end
end
