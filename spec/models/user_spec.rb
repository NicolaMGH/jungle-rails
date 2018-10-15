require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(first_name: "John", last_name: 'Smith',
                      email: 'johnsmith@123.com', password: 'admin', password_confirmation: 'admin')
  }

  describe 'Validations' do

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a first name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a last name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password confirmation' do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid due to email that has already been taken' do
      subject.save
      @user = User.new(first_name: "John", last_name: "Smith", email: "JOHNsmith@123.COM", password: "12345", password_confirmation: "12345")
      @user.save
      expect(@user.errors[:email]).to include("has already been taken")
    end

    it 'is not valid due to password confirmation not matching password' do
      subject.password_confirmation = 'ABCDE'
      expect(subject).to_not be_valid
    end

    it 'is not valid due to password being too short' do
      subject.password = '123'
      subject.password_confirmation = '123'
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should log the user in if the credentials are correct' do
      subject.save!
      expect(User.authenticate_with_credentials("johnsmith@123.com", "admin")).to be_present
    end

    it 'should not log the user in if the email is incorrect' do
      subject.save!
      expect(User.authenticate_with_credentials("jj@123.com", "admin")).to_not be_present
    end

    it 'should not log the user in if the password is incorrect' do
      subject.save!
      expect(User.authenticate_with_credentials("johnsmith@123.com", "123456")).to_not be_present
    end
    it 'should log the user in even if the email contains spaces' do
      subject.save!
      expect(User.authenticate_with_credentials("   johnsmith@123.com   ", "admin")).to be_present
    end

    it 'should log the user in even if it is written in the wrong case' do
      subject.save!
      expect(User.authenticate_with_credentials("   JOHNsmiTH@123.COM   ", "admin")).to be_present
    end
  end
end
