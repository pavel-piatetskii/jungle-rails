require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    # Valid save operation
    it 'saves a user with all fields filled and valid' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      expect(@user.save).to be(true)
    end

    # No name
    it 'fails to save a user without name and show appropriate message' do
      @user = User.new({
        name: nil,
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      expect(@user.save).to be(false)
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'fails to save a user with just one word in the "name field" and show appropriate message' do
      @user = User.new({
        name: nil,
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      expect(@user.save).to be(false)
      expect(@user.errors.full_messages).to include("Name is invalid")
    end

  end
end
