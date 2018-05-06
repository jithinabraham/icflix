FactoryBot.define do
  factory :tenant do
    name { FFaker::Name.name }
    api_key { SecureRandom.urlsafe_base64 }
  end
end
