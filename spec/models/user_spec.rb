require 'rails_helper'


  # 1. Perform test for validation / presence of 
  
=begin

  1. user_name
  2. password_digest
  3. session_token
  
  Methods:

  FIGVAPER

  1. find_by_credentials
  2. is_password?
  3. generate_session_token
  4. validates
  5. after_initialize session_token
  6. password=(password)
  7. ensure_session_token
  8. reset_session_token!

=end

RSpec.describe User, type: :model do

  before :each do
    create(:user)
  end

  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:user_name) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:session_token) }
      it { should validate_length_of(:password).is_at_least(6) }
    end

    context "uniqueness" do
      it { should validate_uniqueness_of(:user_name) }
      it { should validate_uniqueness_of(:session_token) }
    end
  end

  describe "::find_by_credentials" do
    context "finds a user by their user_name and password" do           
    let(:user) { User.create!(user_name: 'user', password: 'password')} 
     
      it 'returns user if user is found' do
        username = user.user_name
        password = 'password'
        expect(User.find_by_credentials(username, password)).to eq(user)
      end

      it 'returns nil if user is not found' do
        expect(User.find_by_credentials('none', 'nothing')).to be_nil
      end

    end
  end

  describe "#is_password?(password)" do
     let(:user) { User.create(user_name: 'user', password: 'password')} 
        correct_pwd = "password"
      incorrect_pwd = "whatever"
  
    context 'if password is correct' do
      it 'returns true' do
        expect(user.is_password?(correct_pwd)).to be_truthy
      end
    end

    context 'if password is incorrect' do 
      it "returns false" do
        expect(user.is_password?(incorrect_pwd)).to be_falsey
      end
    end
  end

  describe "#generate_session_token" do
    random_token = SecureRandom::urlsafe_base64
    random_token2 = SecureRandom::urlsafe_base64
    it "generates random session token" do
      expect(random_token).to_not eq(random_token2)
    end
  end
end