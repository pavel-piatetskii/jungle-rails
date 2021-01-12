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


    ### Name Section ###
    # No name
    it 'fails to save a user without a name' do
      @user = User.new({
        name: nil,
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    # Invalid name
    it 'fails to save a user with just one word in the "name field"' do
      @user = User.new({
        name: 'Johnny',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Name is invalid")
    end


    ### Password Section ###
    # No password
    it 'fails to save a user without a password' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: nil,
        password_confirmation: nil
      })
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    # Non-matching passwords
    it 'fails to save a user with non-matching passwords' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'gosleep'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end    

    # Password has less then 6 characters
    it 'fails to save a user with non-matching passwords' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wak',
        password_confirmation: 'wak'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end


    ### Email Section ###
    # No email
    it 'fails to save a user without an email' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: nil,
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    # Email must be unique and case-insensitive
    it 'fails to save a user with an existing email, but in opposite case' do
      @user1 = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user1.save
      @user2 = User.new({
        name: 'Keanu Reeves',
        email: 'SAMURAI@EXAMPLE.COM',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end


  describe '.authenticate_with_credentials' do
    
    # Successful authentication returns user object
    it 'authentificates user with valid credentals' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      user_auth = User.authenticate_with_credentials('samurai@example.com', 'wakeup')
      expect(user_auth.name).to eq('Johnny Silverhand')
    end

    # Failed authentication returns nil
    it 'returns nil is credentials are wrong' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      user_auth = User.authenticate_with_credentials('samurai@example.com', 'wake')
      expect(user_auth).to eq(nil)
    end

    # Authentication succeeds if a user enters extra spaces before / after email
    it 'authenticates user with valid credentals' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'samurai@example.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      user_auth = User.authenticate_with_credentials('   samurai@example.com   ', 'wakeup')
      expect(user_auth.name).to eq('Johnny Silverhand')
    end

    # Authentication succeeds despite the case of email characteers
    it 'authenticates user with valid case-insensitive email' do
      @user = User.new({
        name: 'Johnny Silverhand',
        email: 'Samurai@examplE.com',
        password: 'wakeup',
        password_confirmation: 'wakeup'
      })
      @user.save
      user_auth = User.authenticate_with_credentials('Samurai@examplE.com', 'wakeup')
      expect(user_auth.name).to eq('Johnny Silverhand')
    end

  end

end
