Question.find_each do |question|
  (1..5).to_a.sample.times do
    question.answers.create!(description: Faker::Bank.name, provider: User.all.sample)
  end
  (1..3).to_a.sample.times do
    question.answers.create!(description: Faker::Bank.name, provider: User.all.sample, is_personal: true)
  end
end