require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations check' do
    it 'is valid with valid attributes' do
      expect(User.new(email: 'm@yandex.ru', password: '123456', password_confirmation: '123456')).to be_valid
    end
  end
end
