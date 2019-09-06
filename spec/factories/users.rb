FactoryBot.define do
  factory :user do
    user_name { Faker::Twitter.screen_name }
    session_token { SecureRandom::urlsafe_base64 }
    password_digest { BCrypt::Password.create('password') }
  end
end