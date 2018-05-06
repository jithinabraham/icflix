FactoryBot.define do
  factory :answer do
    description { FFaker::Book.title }
    association :provider, factory: :user
    question
    is_personal [true, false].sample
  end

  trait :personal do
    is_personal true
  end

  trait :public do
    is_personal false
  end
end
