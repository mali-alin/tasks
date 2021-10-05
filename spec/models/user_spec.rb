require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    FactoryBot.create(:user)
  end

  context 'validations check' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is invalid without necessary attribute' do
      expect(User.new(password: '123456')).to_not be_valid
    end
  end

  context 'check methods' do
    describe '#set_name' do
      it 'sets name when name is blank' do
        expect(user.name).to be_truthy
      end
    end
  end
end
