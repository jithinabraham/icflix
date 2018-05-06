FactoryBot.define do
  factory :question do
    description { FFaker::Book.title }
    association :asker, factory: :user

    trait :with_answers do
      transient do
        answer_count 2
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answer_count, question: question)
      end
    end
  end
end
